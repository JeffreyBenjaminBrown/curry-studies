module TestData where

import FiniteMap

import Rslt
import Index


testFiles :: Files
testFiles = listToFM (<)
  [ (0, Word "")
  , (1, Word "dog")
  , (2, Word "oxygen")
  , (3, Word "needs")
  , (4, Template [0,3,0])
  , (5, Rel [1,2] 3)
  , (6, Paragraph [("The first relationship in this graph is ", 5)] ".")
  ]

testIndex = index testFiles
