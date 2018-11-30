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
  | ImgOfWord String
  | ImgOfRel [ImgOfExpr] ImgOfExpr
    -- ^ the last ImgOfExpr in an ImgOfRel should be an image of a Template
  | ImgOfTemplate [ImgOfExpr] deriving (Show, Eq, Ord)

class HasArity a where
  arity :: a -> Arity

instance HasArity Expr where
  arity (Word _)        = 0
  arity (Rel x _)       = length x
  arity (Template x)    = length x
  arity (Paragraph x _) = length x


-- | = "A graph" = one `Files` + one `Index`.
-- The index is derived from the files.

-- | The Files are used to retrieve the text of Words and Paragraphs.
-- Everything in the Index can be derived from the Files.
type Files = FM Int Expr -- TODO use ordinary hard-disk files

instance (Show a, Show b) => Show (FM a b) where
  show = show . fmToList

-- | The Index can answer every fundamental connectivity question:
-- What is in something, what is something in, etc.
-- It can also find anything findable -- i.e. anything but a Paragraph.
data Index = Index {
  indexOf :: ImgOfExpr -> Maybe Address
  , variety :: Address -> (Expr', Arity)
  , positionsIn :: Address -> Maybe (FM Role Address)
    -- ^ whereas this set is probably small
  , positionsHeldBy :: Address -> SetRBT (Role, Address)
    -- ^ requires random access, because the set could be big
  }
