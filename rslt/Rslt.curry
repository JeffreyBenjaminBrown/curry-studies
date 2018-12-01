module Rslt where

import FiniteMap
import SetRBT


type Address = Int
type Arity = Int

data Expr = Word String
  | Rel [Address] Address
    -- ^ The last Address (the one not in the List) should be to a Template.
    -- ^ Rels are like Lists in that the weird bit (Nil|Template) comes last.
  | Template [Address] -- ^ These Addresses are probably to Words.
  | Paragraph [(String, Address)] String
    -- ^ The Strings in a Paragraph are like a single-use Template.
    -- A Paragraph has Members, but (unlike a Rel) no Template.
    -- Paragraphs are like Templates, in that |Members| + 1 = |Strings|.
    -- Paragraphs are like Lists, in that the weird bit comes last.
    -- Paragrpah is the only kind of Expr not in the index.
  deriving (Show, Eq, Ord)

data Expr' = Word' | Rel' | Template' | Paragraph'
  deriving (Show, Eq, Ord)

data Role = RoleTemplate | RoleMember Int deriving (Show, Eq, Ord)

-- | Something used to locate an Expr in an Index,
-- given varying degrees of identifying information.
data ImgOfExpr = ImgOfExpr Expr
  | ImgOfAddress Address
  | ImgOfRel [ImgOfExpr] ImgOfExpr
  | ImgOfTemplate [ImgOfExpr] deriving (Show, Eq, Ord)

arity :: Expr -> Arity
arity (Word _)        = 0
arity (Rel x _)       = length x
arity (Template x)    = length x - 1
arity (Paragraph x _) = length x


-- | = A "database" = one `Files` + one `Index`.
-- The index is derived from the files.

-- | The `Files` are used to retrieve the text of Words and Paragraphs.
type Files = FM Int Expr -- TODO use ordinary hard-disk files

instance (Show a, Show b) => Show (FM a b) where
  show = show . fmToList

data DbError = AddressNotInDb Address
  | RelDoesNotMatchTemplateInArity Address

-- | The `Index` can answer every fundamental connectivity question:
-- What is in something, what is something in, etc.
-- It can also find anything findable -- i.e. anything but a `Paragraph`.
data Index = Index {
  addressOf         :: ImgOfExpr -> Maybe Address
  , variety         :: Address   -> Maybe (Expr', Arity)
  , positionsIn     :: Address   -> Maybe (FM Role Address)
  , positionsHeldBy :: Address   -> Maybe (SetRBT (Role, Address))
  }
