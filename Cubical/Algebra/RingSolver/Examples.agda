{-# OPTIONS --safe #-}
module Cubical.Algebra.RingSolver.Examples where

open import Cubical.Foundations.Prelude
open import Cubical.Data.Int.Base hiding (_+_ ; _·_ ; _-_)
open import Cubical.Data.List

open import Cubical.Algebra.CommRing
open import Cubical.Algebra.RingSolver.ReflectionSolving

private
  variable
    ℓ : Level


module Test (R : CommRing ℓ) where
  open CommRingStr (snd R)

  _ : 0r ≡ 0r
  _ = solve R

  _ :   1r · (1r + 0r)
      ≡ (1r · 0r) + 1r
  _ = solve R

  _ :   1r · 0r + (1r - 1r)
      ≡ 0r - 0r
  _ = solve R

  _ : (x : fst R) → x ≡ x
  _ = solve R

  _ : (x y : fst R) → x ≡ x
  _ = solve R

  _ : (x y : fst R) → x + y ≡ y + x
  _ = solve R

  _ : (x y : fst R) → (x + y) · (x - y) ≡ x · x - y · y
  _ = solve R

  {-
    A bigger example, copied from the other example files:
  -}
  _ : (x y z : (fst R)) → (x + y) · (x + y) · (x + y) · (x + y)
                ≡ x · x · x · x + (fromℤ R 4) · x · x · x · y + (fromℤ R 6) · x · x · y · y
                  + (fromℤ R 4) · x · y · y · y + y · y · y · y
  _ = solve R

  {-
    Keep in mind, that the solver can lead to wrong error locations.
    For example, the commented code below tries to solve an equation that does not hold,
    with the result of an error at the wrong location.

  _ : (x y : (fst R)) → x ≡ y
  _ = solve R
  -}

module TestInPlaceSolving (R : CommRing ℓ) where
   open CommRingStr (snd R)

   testWithOneVariabl : (x : fst R) → x + 0r ≡ 0r + x
   testWithOneVariabl x = solveInPlace R (x ∷ [])

   testEquationalReasoning : (x : fst R) → x + 0r ≡ 0r + x
   testEquationalReasoning x =
     x + 0r                       ≡⟨solve R withVars (x ∷ []) ⟩
     0r + x ∎

   testWithTwoVariables :  (x y : fst R) → x + y ≡ y + x
   testWithTwoVariables x y = x + y ≡⟨solve R withVars (x ∷ y ∷ []) ⟩ y + x ∎
{-
   testEquationalReasoning' : (x : fst R) (p : 0r + x ≡ 1r) → x + 0r ≡ 0r + x
   testEquationalReasoning' x p =
     x + 0r              ≡⟨solve R withVars (x ∷ []) ⟩
     0r + x              ≡⟨ refl ⟩
     0r + x ∎
-}

