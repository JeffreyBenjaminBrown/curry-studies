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

-- TODO : Use catMaybes to skip anything with an empty list of positions
filesPositions :: Files -> [(Address, [(Role, Address)])]
filesPositions = map f . fmToList
  where f :: (Address, Expr) -> (Address, [(Role,Address)])
        f (a, expr) = (a, exprPositions expr)

index :: Index
index = Index { indexOf = indexOf'
              , positionsOf = positionsOf'
              , rolesIn = rolesIn'
              , inRole = inRole' } where
  indexOf' = error "1"
  positionsOf' = error "2"
  rolesIn' = error "3"
  inRole' = error "4"
