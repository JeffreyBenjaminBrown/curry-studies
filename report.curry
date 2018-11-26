-- | = people
data Person = John | Christine | Alice | Andrew deriving (Eq,Ord)
mother John = Christine

-- | case is not like fcase
x = case () of
  _ -> False
  _ -> True

-- | = Map colorings
data Color = Red | Green | Blue deriving Eq

-- isColor :: Color  -> Bool
-- isColor Red = True
-- isColor Yellow = True
-- isColor Green = True
-- isColor Blue = True

-- coloring :: Color -> Color -> Color -> Color -> Bool
-- coloring l1 l2 l3 l4 = isColor l1 & isColor l2 & isColor l3 & isColor l4

correct :: Color -> Color -> Color -> Color -> Bool
correct l1 l2 l3 l4 =   l1 /= l2
                      & l1 /= l3
                      & l2 /= l3
                      & l2 /= l4
                      & l3 /= l4

-- to find all solutions:
-- correct l1 l2 l3 l4 where  l1, l2, l3, l4 free
