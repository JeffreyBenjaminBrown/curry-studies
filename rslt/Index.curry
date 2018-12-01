{-# OPTIONS_CYMAKE -F --pgmF=currypp --optF=defaultrules #-}

module Index where

import Maybe (isNothing)
import FiniteMap
import SetRBT

import Rslt
import Index.Positions
import Index.ImgLookup


-- | = Build the database

-- TODO (#strict) Evaluate `Index` completely at start of program.
index :: Files -> Index
index files = Index { addressOf       = imgLookup files
                    , variety         = variety'
                    , positionsIn     = positionsIn'
                    , positionsHeldBy = positionsHeldBy'
                    }
 where
  fps = positionsWithinAll files :: [(Address, [(Role, Address)])]

  variety' :: Address -> Maybe (Expr', Arity)
  variety' = lookupFM varieties where
    -- (#strict) Build `varieties` completely first.
    varieties = mapFM (\_ v -> exprVariety v) files

  positionsIn' :: Address -> Maybe (FM Role Address)
  positionsIn' = lookupFM positions where
    -- (#strict) Build `positions` completely first.
    positions :: FM Address (FM Role Address)
    positions = mapFM (\_ v -> listToFM (<) v) $ listToFM (<) fps

  positionsHeldBy' :: Address -> Maybe (SetRBT (Role, Address))
  positionsHeldBy' = lookupFM $ positionsHeldByAll fps
    -- (#strict) Build `positionsHeldByAll fps` completely first.


-- | = Check the database

collectionsWithAbsentAddresses :: Files -> Index -> FM Address [Address]
collectionsWithAbsentAddresses files index = res where
  res = filterFM (\_ v -> not $ null v)
        $ mapFM (\_ v -> filter absent $ involved v) collections

  absent :: Address -> Bool
  absent = isNothing . variety index

  involved :: Expr -> [Address]
  involved (Word _)          = error "impossible"
  involved (Template as)     = as
  involved (Rel as a)        = a : as
  involved (Paragraph sas _) = map snd sas

  collections :: Files
  collections = filterFM (\_ v -> isCollection v) files where
    isCollection expr = case expr of Word _ -> False
                                     _      -> True

-- | Returns a list of bad `Address`es.
-- TODO Report for each bad `Address` the kind of problem.
relsWithoutMatchingTemplates :: Files -> Index -> Files
relsWithoutMatchingTemplates files index = res where
  res = filterFM (\_ e -> not $ relMatchesTemplateArity e) rels

  -- PITFALL: Intentionally partial (only Rels).
  relMatchesTemplateArity :: Expr -> Bool
  relMatchesTemplateArity e@(Rel _ t) = case variety index t of
    Nothing         -> False
    Just (ctr, art) -> case ctr of
      Template' -> arity e == art
      _         -> False
 
  rels = filterFM (\_ v -> isRel v) files where
    isRel expr = case expr of Rel _ _ -> True
                              _       -> False


-- | = derivable from an `Index`

holdsPosition :: Index -> (Role, Address) -> Maybe Address
holdsPosition i (r,a) = case positionsIn i a of
  Nothing -> Nothing
  Just ps -> lookupFM ps r
