{-# OPTIONS_CYMAKE -F --pgmF=currypp --optF=defaultrules #-}

module Index where

import FiniteMap
import SetRBT

import Rslt
import Index.Positions
import Index.ImgLookup


-- | = Build the database

-- | TODO (#strict) Force full, immediate evaluation of `Index`.
index :: Files -> Index
index files = Index { indexOf = imgLookup files
                    , variety = variety'
                    , positionsIn = positionsIn'
                    , positionsHeldBy = positionsHeldBy'
                    } where

  fps = filesPositions files :: [(Address, [(Role, Address)])]

  variety' :: Address -> Maybe (Expr', Arity)
  variety' = lookupFM $ mapFM (\_ v -> exprVariety v) files

  positionsIn' :: Address -> Maybe (FM Role Address)
  positionsIn' = lookupFM positions where
    positions :: FM Address (FM Role Address)
    positions = mapFM (\_ v -> listToFM (<) v) $ listToFM (<) fps

  positionsHeldBy' :: Address -> Maybe (SetRBT (Role, Address))
  positionsHeldBy' = lookupFM $ invertPositions fps

-- | = Check the database

-- | Returns a list of bad `Address`es.
-- TODO Report for each bad `Address` the kind of problem.
relsWithNonMatchingTemplates :: Files -> Index -> Files
relsWithNonMatchingTemplates files index =
  filterFM (\_ e -> not $ relMatchesTemplateArity e) rels where

  -- PITFALL: Intentionally partial (only Rels).
  relMatchesTemplateArity :: Expr -> Bool
  relMatchesTemplateArity e@(Rel _ t) = case variety index t of
    Nothing         -> False
    Just (ctr, art) -> case ctr of
      Template' -> arity e == art
      _         -> False

  rels = filterFM pred files where
    pred _ x   = isRel x
    isRel expr = case expr of Rel _ _ -> True
                              _       -> False

-- | = derivable from an `Index`

holdsPosition :: Index -> (Role, Address) -> Maybe Address
holdsPosition i (r,a) = case positionsIn i a of
  Nothing -> Nothing
  Just ps -> lookupFM ps r
