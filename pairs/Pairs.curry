module Pairs where

type P = (Int,Int)

data PQuery =  PImg [P]     |  PAnd [PQuery] |  POr [PQuery]
            |  PNot PQuery  |  PHas Int -- non-runnable conditions
            |  PVar String  |  PAnonVar Int

runQuery :: PQuery -> Int
runQuery (PImg is) | fElem i is = i

-- | `f` is for `flexible`
fElem :: Eq a => a -> [a] -> Bool
fElem a (a : _)  = True
fElem a (_ : as) = fElem a as
fElem _ []       = False
