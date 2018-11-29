module SomeData where

import FiniteMap
import SetRBT

import Rslt


files :: Files
files = listToFM (<)
  [ (0, Word "")
  , (1, Word "dog")
  , (2, Word "oxygen")
  , (3, Word "needs")
  , (4, Template [0,3,0])
  , (5, Rel [1,2] 3)
  , (6, Paragraph [("The first relationship in this graph is ", 5)] ".")
  ]

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

-- | TODO #strict: force full evaluation of index immediately
index :: Index
index = Index { indexOf = error "1"
              , positionsHeldBy = error "2"
              , positionsIn = positionsIn'
              , holdsPosition = error "4" } where
  positionsIn' :: Address -> [(Role, Address)]
  positionsIn' a = let m = listToFM (<) $ filesPositions files
    in case lookupFM m a of Nothing -> []
                            Just ps -> ps
