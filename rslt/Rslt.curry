module Rslt where

import FiniteMap
import SetRBT


type Address = Int
type Arity = Int

data Expr = Word String
  | Rel [Address] (Address)
    -- ^ The last Address (the one not in the List) should be to a Template.
    -- ^ Rels are like Lists in that the weird Expr's Address comes last.
  | Template [Address] -- ^ These Addresses are probably to Words.
  | Paragraph [(String, Address)] String
    -- ^ The only kind of Expr not in the index.
    -- Paragraphs are like Templates, in that |Members| + 1 = |Strings|.
    -- Paragraphs are like Lists, in that the weird constructor comes last.
    -- The Strings in a Paragraph are like a single-use Template.
    -- A Paragraph has Members, but (unlike a Rel) no Template.

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
  arity (Word _)        = 0
  arity (Rel x _)       = length x
  arity (Paragraph x _) = length x
  arity (Template x)    = length x

-- arityInIndex :: Index -> ExprImg -> Arity


-- | Eventually the filesystem will do this; for now it's in memory.
type Files = FM Int Expr

data Index = Index {
  indexOf :: ExprImg -> Address
  , positionsOf :: Address -> SetRBT Position
--  , rolesOf :: Address -> 
  , inRole :: Position -> Address
  }
