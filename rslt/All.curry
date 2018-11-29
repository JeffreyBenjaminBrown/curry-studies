-- | = This module lets me load a lot of modules fast,
-- and avoid having creating an unreadably-long prompt in the Pakcs Repl.

module All (module M) where

import Rslt as M
import SomeData as M
import FiniteMap as M
import Tests as M
