{-# OPTIONS_CYMAKE -F --pgmF=currypp --optF=defaultrules #-}

module Index.ImgLookup where

import Maybe
import FiniteMap

import Rslt
import Util (hasANothing)


exprVariety :: Expr -> (Expr', Arity)
exprVariety e@(Word      _)   = (Word'      , 0)
exprVariety e@(Template  _)   = (Template'  , arity e)
exprVariety e@(Rel       _ _) = (Rel'       , arity e)
exprVariety e@(Paragraph _ _) = (Paragraph' , arity e)

-- | Produces the kind of key used to look up `ImgOfExpr`s.
exprImgKey :: Expr -> Maybe Expr
exprImgKey (Paragraph _ _) = Nothing
exprImgKey'default x = Just x -- TODO : Why the warning?

imgDb :: Files -> FM Expr Address
imgDb = listToFM (<) . catMaybes . map f . fmToList where
  f (addr, expr) = case exprImgKey expr of
    Nothing -> Nothing
    _       -> Just (expr, addr)

imgLookup :: Files -> ImgOfExpr -> Maybe Address
imgLookup files img = let idb = imgDb files in case img of

  ImgOfExpr    e -> lookupFM idb e
  ImgOfAddress a -> maybe Nothing (const $ Just a) $ lookupFM files a

  ImgOfTemplate is ->
    let mas = map (imgLookup files) is
    in case hasANothing mas of
         True -> Nothing
         False -> lookupFM idb $ Template $ catMaybes mas

  ImgOfRel is i ->
    let mas = map (imgLookup files) is
        ma = imgLookup files i
    in case hasANothing mas || isNothing ma of
         True -> Nothing
         False -> lookupFM idb $ Rel (catMaybes mas) $ fromJust ma
