module Tests where

import FiniteMap

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

