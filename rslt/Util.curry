import RedBlackTree
import SetRBT

listToSetRBT :: Ord a => [a] -> SetRBT a -- TODO How to use from REPL?
listToSetRBT = foldl (flip insertRBT) (emptySetRBT (<))
