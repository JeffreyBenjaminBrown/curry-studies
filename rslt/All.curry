-- | = This module lets me load a lot of modules fast,
-- and avoid having creating an unreadably-long prompt in the Pakcs Repl.

module All ( module M
           ) where

import FiniteMap as M
import SetRBT as M
import RedBlackTree as M

import Rslt as M
import Index as M
import Index.Positions as M
import Index.ImgLookup as M
import TestData as M
import Tests as M
import Util as M
