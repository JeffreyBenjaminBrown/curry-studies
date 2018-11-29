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

-- TODO : substitute (SetRBT (Role, Address)) for [(Role, Address)]
addInvertedPosition :: FM Address [(Role, Address)]
                    -> (Address, [(Role, Address)])
                    -> FM Address [(Role, Address)]
addInvertedPosition fm (a1, ras) = foldl f fm ras
  where f :: FM Address [(Role, Address)]
          -> (Role, Address)
          -> FM Address [(Role, Address)]
        f fm (r,a) = addToFM_C (flip (++)) fm a [(r,a1)]
  -- flip the (++) so that we only have to traverse the singleton [(r,a)]
  -- rather than the potentially long result of looking up `a` in `fm`

-- | PITFALL: The input and output look similar, but they mean
-- different things. The first is a list from addresses to the positions
-- they contain. The second is a list from addresses to the positions that
-- contain them.
invertPositions :: [( Address, [(Role, Address)] )]
                -> FM Address [(Role, Address)]
invertPositions aras = foldl addInvertedPosition (emptyFM (<)) aras


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
