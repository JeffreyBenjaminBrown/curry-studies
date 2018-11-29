module Tests where


import FiniteMap as M
import SetRBT as M
import RedBlackTree as M

import Rslt
import SomeData


tests = [ testAddInvertedPosition
        , testInvertPositions ]

testAddInvertedPosition =
  fmToList ( addInvertedPosition (emptyFM (<)) (1, [ (RoleMember 1, 11)
                                                   , (RoleMember 2, 22) ] )
           ) == [ (11, [(RoleMember 1,1)] )
                , (22, [(RoleMember 2,1)] )
                ]

testInvertPositions =
  fmToList ( invertPositions [ (1, [ (RoleMember 1, 11)
                                   , (RoleMember 2, 22) ] )
                             , (11, [ (RoleMember 1, 1)
                                    , (RoleMember 2, 22) ] )
                             , (3, [ (RoleMember 1, 1) ] )
                             ]
           ) == [(1,[(RoleMember 1,3)
                    ,(RoleMember 1,11)])
                ,(11,[(RoleMember 1,1)])
                ,(22,[(RoleMember 2,11)
                     ,(RoleMember 2,1)])]

-- TODO I can call `broken` fron the REPL,
-- but I can't evaluate the RHS of its definition there.
broken :: SetRBT Int
broken = insertRBT 1 $ emptySetRBT (<)
