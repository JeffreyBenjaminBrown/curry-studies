-- Someone on StackOverflow recommended this:
{-# OPTIONS_CYMAKE -F --pgmF=currypp --optF=defaultrules #-}

import SetRBT
import Char
import SetFunctions


abs :: (Num a, Ord a) => a -> a
abs x = if x > 0 then x else -x

fac :: Int -> Int
fac n | n < 0 = error "no"
      | n==0 = 1
      | otherwise = n * fac (n-1)

freeBool :: Bool
freeBool = x && (y || (not x)) where x,y free

pneg :: Bool -> Bool
pneg True = False

c_choose :: a -> a -> a
c_choose x _ = x
c_choose _ y = y

(./.) :: Int -> Int -> Bool
infix 7 ./.
a ./. b =
  a /= 0 && b `mod` a == 0

data task = cut | polish
data worker =  Alex | Bert | Chuck deriving Eq

assign :: task -> worker
assign cut = Alex
assign cut = Bert
assign polish = Bert
assign polish = Chuck

team :: (worker, worker)
team | x /= y = (x,y)
  where x = assign cut 
        y = assign polish

last :: [a] -> a
last (_++[e]) = e


-- | Extract all sublists that end at twice their starting point
endsDoubled :: (Num a, Eq a) => [a] -> [a]
endsDoubled (    _
              ++ x@( [a] ++ _ ++ [b] )
              ++ _
            ) | b == 2*a
  = x


-- | default rules
-- The default rule is executed only if none of the other conditions apply.
-- This permits a successful search to avoid returning the faied-search case,
-- and permits one to resume control after a failed search.
--
-- myLookup 1 [(1,2)]
-- myLookup 2 [(1,2)]
-- myLookup2 1 [(1,2)]
-- myLookup2 2 [(1,2)]

-- | This has no default rule
myLookup :: k -> [(k,v)] -> Maybe v
myLookup key (_++[(key,value)]++_ ) = Just value
myLookup _ _ = Nothing

-- | This has a default rule
myLookup2 :: k -> [(k,v)] -> Maybe v
myLookup2 key (_++[(key,value)]++_ ) = Just value
myLookup2'default _ _ = Nothing

-- | = not sure why I wrote this
myGte :: (Num a, Ord a) => a -> a -> Bool
myGte a b | a >= b = True
myGte _ _ = False

-- | = A parsing exercise (p. 35 of the Curry tutorial (sec 3.13.4)
data Term = Term String [Term]
parseTerm (fun++"("++args++")")
  | all isAlpha fun
  = Term fun (parseArgs args)
parseTerm s
  | all isAlpha s
  = Term s []
parseArgs (term++","++terms) = parseTerm term : parseArgs terms
parseArgs s = [parseTerm s]

fileLength :: IO ()
fileLength = do f <- getLine >>= readFile
                putStrLn $ show $ length f

si :: SetRBT Int
si = foldl (flip insertRBT) (emptySetRBT (<)) [1,2,3]

aTest :: Int -> Int
aTest a | x =:= a && elemRBT x si = x where x free


-- | = Exercise: Find a full house

type Card = (Suit, Rank)
type Rank = Int
data Suit = Club | Diamond | Heart | Spade

suit :: Card -> Suit
suit = fst
rank :: Card -> Rank
rank = snd

isFullHouse :: [Card] -> Maybe (Int,Int)
isFullHouse (x++[a]++y++[b]++z)
  | map rank (x++y++z) == [m,m,m]
    && map rank [a,b] == [n,n]
  = Just (m,n)
  where m,n free
isFullHouse _ = Nothing
-- It works!
-- isFullHouse [(Club,2), (Heart,8), (Diamond,2), (Spade,8), (Heart,2)]


-- | ugly fibonacci
fibo = map fst fibopairs
fibopairs = (0,1):[(y,x+y)|(x,y)<-fibopairs]


-- | = powerset
subset [] = []
subset (x:xs) = x:subset xs
subset (_:xs) = subset xs
powerset s = SetFunctions.set1 subset s


-- | = Deep selection: find every Var in a nested Expr

data Expr = Lit Int
          | Var [Char]
          | Add Expr Expr
          | Mul Expr Expr

withSub exp = exp
            ? op (withSub exp) unknown
            ? op unknown (withSub exp)
  where op = Add ? Mul

varOf :: Expr -> String
varOf (withSub (Var v)) = v

allVarsOf :: Expr -> SetFunctions.Values String
allVarsOf = SetFunctions.set1 varOf
