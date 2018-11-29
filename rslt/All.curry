-- | = This module lets me load a lot of modules fast,
-- and avoid having creating an unreadably-long prompt in the Pakcs Repl.

module All ( module M
           , broken
           ) where

import FiniteMap as M
import SetRBT as M
import RedBlackTree as M

import Rslt as M
import SomeData as M
import Tests as M
import Util as M


-- TODO I can call `broken` fron the REPL,
-- but I can't evaluate the RHS of its definition there.
broken :: SetRBT Int
broken = insertRBT 1 $ emptySetRBT (<)
