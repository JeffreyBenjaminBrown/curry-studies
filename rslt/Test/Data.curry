module Test.Data where

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
  , (5,    Rel [1,2] 4)
  , (1001, Rel [1,2] 5)       -- bad, on purpose
  , (1002, Rel [1,2] (-1000)) -- bad, on purpose
  , (6, Paragraph [("The first relationship in this graph is ", 5)] ".")
  ]

testIndex :: Index
testIndex = index testFiles
