module Util where

import List
import SetRBT


listToSetRBT :: Ord a => [a] -> SetRBT a
listToSetRBT = foldl (flip insertRBT) $ emptySetRBT (<)

-- | `sort (<)` sorts a list in increasing order.
sort :: Ord a => (a -> a -> Bool) -> [a] -> [a]
sort _ [] = []
sort ordered (a:as) = let (gt, lt) = partition (ordered a) as
                      in sort ordered lt ++ [a] ++ sort ordered gt
