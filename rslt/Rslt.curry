module Rslt where

import SetRBT


type Address = Int
type Arity = Int

data Expr = Word String
  | Rel [Address] (Address)
     -- ^ The last Address (the one not in the List) should be to a Template.
    -- ^ Rels are like Lists in that the weird Expr's Address comes last.
  | ExprParagraph Paragraph -- ^ The only kind of Expr not in the index.
    -- The Strings in a Paragraph are like a single-use Template.
    -- A Paragraph has Members, but (unlike a Rel) no Template.
  | Template [Address] -- ^ These Addresses are probably to Words.

-- | Paragraph = A List of (String,Address) pairs, capped by a String.
-- Paragraphs are like Templates, in that |Members| + 1 = |Strings|.
-- Paragraphs are like Lists, in that the weird constructor comes last.
data Paragraph = Paragraph [(String, Address)] String

data Role = RoleTemplate | RoleMember Int

-- | Like a position at an employer: includes host and role.
type Position = (
  Address -- ^ the Address should be of a Rel|Paragraph|Template
  , Role )

data ExprImg = ImgAddress Address
  | ExprImg Expr
  | ImgWord String
  | ImgRel (ExprImg) [ExprImg] -- ^ the first ExprImg should be of a Template
  | ImgTemplate [ExprImg]

class HasArity a where
  arity :: a -> Arity

instance HasArity Expr where
  arity (Word _)                        = 0
  arity (Rel x _)                       = length x
  arity (ExprParagraph (Paragraph x _)) = length x
  arity (Template x)                    = length x

instance HasArity (ExprImg, Index) where
  

-- instance HasArity ExprImg where -- TODO
-- getExpr :: Address -> IO Expr -- TODO

data Index = Index {
  indexOf :: ExprImg -> Address
  , containersOf :: Address -> SetRBT Position
  , inRole :: Position -> Address
  }
