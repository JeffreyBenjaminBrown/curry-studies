{-# OPTIONS_CYMAKE -F --pgmF=currypp --optF=defaultrules #-}

module Index where

import FiniteMap
import SetRBT

import Rslt
import Index.Positions
import Index.ImgLookup


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


-- | = derivable from an `Index`

holdsPosition :: Index -> (Role, Address) -> Maybe Address
holdsPosition i (r,a) = case positionsIn i a of
  Nothing -> Nothing
  Just ps -> lookupFM ps r
