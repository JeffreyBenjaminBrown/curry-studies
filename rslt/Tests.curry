module Tests where


import FiniteMap
import SetRBT
import RedBlackTree

import Rslt
import Index
import Index.Positions
import TestData
import Util


tests :: [Bool]
tests = [ testAddInvertedPosition
        , testInvertPositions
        , testHoldsPosition
        , testVariety
        ]

-- imgLookup testFiles $ ImgOfAddress $ 0
-- imgLookup testFiles $ ImgOfExpr $ Word "needs"
-- imgLookup testFiles $ ImgOfExpr $ Word "oxygen"
-- imgLookup testFiles $ ImgOfExpr $ Template [0,3,0]
-- imgLookup testFiles $ ImgOfTemplate [ImgOfAddress 0, ImgOfExpr $ Word "needs", ImgOfExpr $ Word ""]

testHoldsPosition :: Bool
testHoldsPosition = and
  [ holdsPosition testIndex (RoleMember 1, 4) == Just 0
  , holdsPosition testIndex (RoleMember 2, 4) == Just 3
  , holdsPosition testIndex (RoleMember 2, 5) == Just 2
  , holdsPosition testIndex (RoleMember 1, 5) == Just 1
  , holdsPosition testIndex (RoleTemplate, 5) == Just 3
  , holdsPosition testIndex (RoleTemplate, 6) == Nothing
  ]

testVariety :: Bool
testVariety = and [ variety testIndex 3 == Just (Word',0)
                  , variety testIndex 4 == Just (Template',3)
                  , variety testIndex 5 == Just (Rel',2)
                  , variety testIndex 6 == Just (Paragraph',1)
                  , variety testIndex (-133) == Nothing
                  ]

testAddInvertedPosition :: Bool
testAddInvertedPosition =
  fmToList ( mapFM (\_ v -> sort (<) $ setRBT2list v)
             $ addInvertedPosition (emptyFM (<)) (1, [ (RoleMember 1, 11)
                                                     , (RoleMember 2, 22) ] )
           ) == [ (11, [(RoleMember 1,1)] )
                , (22, [(RoleMember 2,1)] )
                ]

testInvertPositions :: Bool
testInvertPositions =
  let ips = invertPositions [ (1, [ (RoleMember 1, 11)
                                  , (RoleMember 2, 22) ] )
                            , (11, [ (RoleMember 1, 1)
                                   , (RoleMember 2, 22) ] )
                            , (3, [ (RoleMember 1, 1) ] )
                            ]
      ips' = fmToList $ mapFM (\_ v -> sort (<) $ setRBT2list v) ips
  in ips' == [(1,[(RoleMember 1,3)
                 ,(RoleMember 1,11)])
             ,(11,[(RoleMember 1,1)])
             ,(22,[(RoleMember 2,1)
                  ,(RoleMember 2,11)])]

-- TODO I can call `broken` fron the REPL,
-- but I can't evaluate the RHS of its definition there.
broken :: SetRBT Int
broken = insertRBT 1 $ emptySetRBT (<)
