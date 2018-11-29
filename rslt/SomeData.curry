module SomeData where

import FiniteMap
import SetRBT

import Rslt


files :: Files
files = listToFM (<)
  [ (0, Word "")
  , (1, Word "dog")
  , (2, Word "oxygen")
  , (3, Word "needs")
  , (4, Template [0,3,0])
  , (5, Rel [1,2] 3)
  , (6, Paragraph [("The first relationship in this graph is ", 5)] ".")
  ]

