module Index where

import FiniteMap
import SetRBT

import Rslt


exprVariety :: Expr -> (Expr', Arity)
exprVariety (Word _)          = (Word'      , 0)
exprVariety (Template mas)    = (Template'  , length mas)
exprVariety (Rel mas _)       = (Rel'       , length mas)
exprVariety (Paragraph sas _) = (Paragraph' , length sas)

exprPositions :: Expr -> [(Role,Address)]
exprPositions expr =
  let f :: (Int, Address) -> (Role, Address)
      f (n,a) = (RoleMember n, a)
  in case expr of
    Word _          -> []
    Template mas    ->                     map f (zip [1..]           mas)
    Rel mas ta      -> (RoleTemplate,ta) : map f (zip [1..]           mas)
    Paragraph sas _ ->                     map f (zip [1..] $ map snd sas)

filesPositions :: Files -> [(Address, [(Role, Address)])]
filesPositions = filter (not . null . snd) . map f . fmToList
  where f :: (Address, Expr) -> (Address, [(Role,Address)])
        f (a, expr) = (a, exprPositions expr)

addInvertedPosition :: FM Address (SetRBT (Role, Address))
                    -> (Address, [(Role, Address)])
                    -> FM Address (SetRBT (Role, Address))
addInvertedPosition fm (a1, ras) = foldl f fm ras where
  f :: FM Address (SetRBT (Role, Address))
    ->                    (Role, Address)
    -> FM Address (SetRBT (Role, Address))
  f fm (r,a) = addToFM_C unionRBT fm a newData
    where newData :: SetRBT (Role, Address)
          newData = insertRBT (r,a1) $ emptySetRBT (<)

-- | PITFALL: The input and output look similar, but they mean
-- different things. The first is a list from addresses to the positions
-- they contain. The second is a list from addresses to the positions that
-- contain them.
invertPositions :: [( Address,       [(Role, Address)] )]
                -> FM Address (SetRBT (Role, Address))
invertPositions aras = foldl addInvertedPosition (emptyFM (<)) aras

-- | TODO #strict: force full evaluation of index immediately
index :: Files -> Index
index files = Index { indexOf = error "1"
                 , variety = variety'
                 , positionsHeldBy = positionsHeldBy'
                 , positionsIn = positionsIn'
                 } where
  fps = filesPositions files :: [(Address, [(Role, Address)])]
  variety' :: Address -> (Expr', Arity)
  variety' = maybe (error "Requested variety of Address not in Index.")
             id . lookupFM varieties
    where varieties = mapFM (\_ v -> exprVariety v) files
  positionsIn' :: Address -> Maybe (FM Role Address)
  positionsIn' = lookupFM positions where
    positions :: FM Address (FM Role Address)
    positions = mapFM (\_ v -> listToFM (<) v) $ listToFM (<) fps
  positionsHeldBy' :: Address -> SetRBT (Role, Address)
  positionsHeldBy' = maybe (emptySetRBT (<)) id 
                     . lookupFM (invertPositions fps)
