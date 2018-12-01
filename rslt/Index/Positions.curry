{-# OPTIONS_CYMAKE -F --pgmF=currypp --optF=defaultrules #-}

module Index.Positions where

import FiniteMap
import SetRBT

import Rslt


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
-- they contain. The second is a map from addresses to the positions that
-- contain them.
invertPositions :: [( Address,       [(Role, Address)] )]
                -> FM Address (SetRBT (Role, Address))
invertPositions aras = foldl addInvertedPosition (emptyFM (<)) aras
