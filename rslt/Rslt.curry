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

data Role = RoleTemplate | RoleMember Int

-- | Like a position at an employer: includes host and role.
type Position = (
  Address -- ^ the Address should be of a Rel|Paragraph|Template
  , Role )

-- | Something used to locate an Expr in an Index,
-- given varying degrees of identifying information.
data ImgExpr = ImgExpr Expr
  | ImgAddress Address
  | ImgWord String
  | ImgRel [ExprImg] ExprImg -- ^ the last ExprImg should be of a Template
  | ImgTemplate [ExprImg]

class HasArity a where
  arity :: a -> Arity

instance HasArity Expr where
  arity (Word _)        = 0
  arity (Rel x _)       = length x
  arity (Template x)    = length x
  arity (Paragraph x _) = length x


-- | Files are used to retrieve the text of Words and Paragraphs.
-- Everything in the Index can be derived from the Files.
type Files = FM Int Expr

-- | The Index can answer every fundamental connectivity question:
-- What is in something, what is something in, etc.
-- It can also find anything findable -- i.e. anything but a Paragraph.
data Index = Index {
  indexOf :: ExprImg -> Address
  , positionsOf :: Address -> SetRBT Position
  , rolesIn :: Address
            -> ( [Address] -- ^ Members
               , Maybe Address) -- ^ Template
  , inRole :: Position -> Address
  }
