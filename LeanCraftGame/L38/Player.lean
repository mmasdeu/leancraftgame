/-
# Spot the bug: algebra

*Sam sends five claims from their algebra notes, for the Prover tonight. Each one is false.
The Prover would refute them in seconds with disproofs nobody reads. Noor wants a
counterexample for each, small enough to check by hand.*

## Claim 1: "a set of integers that contains 0 and is closed under + is a subgroup"

Sam's structures, in the style of level 35:

```lean
structure AddSubmonoidℤ where
  carrier : Set ℤ
  zero_mem : 0 ∈ carrier
  add_mem {a b} : a ∈ carrier → b ∈ carrier → a + b ∈ carrier

structure AddSubgroupℤ where
  carrier : Set ℤ
  zero_mem : 0 ∈ carrier
  add_mem {a b} : a ∈ carrier → b ∈ carrier → a + b ∈ carrier
  neg_mem {a} : a ∈ carrier → -a ∈ carrier
```

Give `junk`, a junk model: a set that satisfies the first structure but not the second.

## Claim 2: "`Ideal.span {2}` is the ideal of the integers divisible by 4 and by 6"

Give `x`, an integer in `Ideal.span {2}` that isn't divisible by both 4 and 6.

## Claim 3: "`(p * q).natDegree = p.natDegree + q.natDegree` for all `p q : ℤ[X]`"

Mathlib's `Polynomial.natDegree_mul` has hypotheses. Give `p` and `q` where the claim
fails. Mathlib's convention: `natDegree 0 = 0`, while `degree 0 = ⊥`.

## Claim 4: "in `ZMod n`, every nonzero element has an inverse"

This is true when `n` is prime, as in level 37. Give a nonzero `a : ZMod 6` with
`a * b ≠ 1` for every `b`.

## Claim 5: "permutations commute: `σ * τ = τ * σ`"

Give `σ τ : Equiv.Perm (Fin 3)` with `σ * τ ≠ τ * σ`, in the S₃ of levels 29 and 36.
-/
import Mathlib.RingTheory.Ideal.Span
import Mathlib.Algebra.Polynomial.Degree.Operations
import Mathlib.GroupTheory.Perm.Basic
import Mathlib.Data.ZMod.Basic

namespace L38

open Polynomial

structure AddSubmonoidℤ where
  carrier : Set ℤ
  zero_mem : 0 ∈ carrier
  add_mem {a b} : a ∈ carrier → b ∈ carrier → a + b ∈ carrier

structure AddSubgroupℤ where
  carrier : Set ℤ
  zero_mem : 0 ∈ carrier
  add_mem {a b} : a ∈ carrier → b ∈ carrier → a + b ∈ carrier
  neg_mem {a} : a ∈ carrier → -a ∈ carrier

-- Claim 1: an additive submonoid of ℤ that isn't a subgroup
def junk : Set ℤ := sorry

-- Claim 2: in Ideal.span {2}, but not divisible by both 4 and 6
def x : ℤ := sorry

-- Claim 3: natDegree (p * q) ≠ natDegree p + natDegree q
def p : ℤ[X] := sorry
def q : ℤ[X] := sorry

-- Claim 4: nonzero, and not invertible in ZMod 6
def a : ZMod 6 := sorry

-- Claim 5: two permutations that don't commute
def σ : Equiv.Perm (Fin 3) := sorry
def τ : Equiv.Perm (Fin 3) := sorry

end L38
