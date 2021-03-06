module Rslt where

import FiniteMap
import SetRBT


type Addr = Int -- ^ Address
type Arity = Int

data Expr = Word String -- ^ (Could be a phrase too.)
  | Rel [Addr] Addr -- ^ "Relationship".
    -- The last `Addr` (the one not in the list) should be to a `Tplt`.
    -- `Rel`s are like lists in that the weird bit (`Nil|Tplt`) comes last.
  | Tplt [Addr] -- ^ A "template" for a `Rel`, like "_ needs _ sometimes."
                -- The `Addr`s are probably to `Word`s.
  | Par [(String, Addr)] String -- ^ "Paragraph".
    -- The `String`s in a `Par` are like a single-use `Tplt`.
    -- A `Par` has Members, but (unlike a `Rel`) no `Tplt`.
    -- `Par`s are like `Tplt`s, in that |Members| + 1 = |`String`s|.
    -- `Par`s are like lists, in that the weird bit comes last.
    -- `Par` is the only kind of `Expr` not in the `Index`.
  deriving (Show, Eq, Ord)

data Expr' = Word' | Rel' | Tplt' | Par'
  deriving (Show, Eq, Ord)

data Role = RoleTplt | RoleMember Int deriving (Show, Eq, Ord)

-- | Something used to locate an `Expr` in an `Index`,
-- given varying degrees of identifying information.
data ImgOfExpr = ImgOfExpr Expr
               | ImgOfAddr Addr
               | ImgOfRel  [ImgOfExpr] ImgOfExpr
               | ImgOfTplt [ImgOfExpr] deriving (Show, Eq, Ord)

arity :: Expr -> Arity
arity (Word _)        = 0
arity (Rel x _)       = length x
arity (Tplt x)    = length x - 1
arity (Par x _) = length x


-- | = A "database" = one `Files` + one `Index`.
-- The index is derived from the files.

-- | The `Files` are used to retrieve the text of `Word`s and `Par`s.
type Files = FM Int Expr -- TODO use ordinary hard-disk files

instance (Show a, Show b) => Show (FM a b) where
  show = show . fmToList

data DbError = AddrNotInDb  Addr
             | ArityMismatch   Addr

-- | The `Index` can answer every fundamental connectivity question:
-- What is in something, what is something in, etc.
-- It can also find anything findable -- i.e. anything but a `Par`.
data Index = Index {
  addressOf         :: ImgOfExpr -> Maybe Addr
  , variety         :: Addr      -> Maybe (Expr', Arity)
  , positionsIn     :: Addr      -> Maybe (FM Role Addr)
  , positionsHeldBy :: Addr      -> Maybe (SetRBT (Role, Addr))
  }
