/-
# Subspaces

A subset `A` of a space inherits a topology: its open sets are the traces
`U ∩ A` of the open sets `U` of the space. This **subspace topology** is the
coarsest one making the inclusion `A → X` continuous, and it is what we mean
when we say that `[0, 1)` is "open in `[0, 1]`" (it is `(-1, 1) ∩ [0, 1]`),
although it is not open in `ℝ`.

So "open" is relative: a set can be open in `A` without being open in `X`.
And a subspace can look nothing like the whole space: the integers are
discrete as a subspace of `ℝ`, which is connected.

We keep the open sets of the subspace as subsets of the big space: the
subspace topology on `A` is the family `{U ∩ A | U ∈ T}`. Its members are
subsets of `A`. `T.image (fun U => U ∩ A)` applies a function to every member
of a family.

## Your task

1. Define `subspace T A`, the family of traces.
2. Define `OpenIn T A W`: `W` is open in the subspace `A`.
3. Construct `A0` and `W0` in the chain `∅ ⊂ {0} ⊂ {0, 1} ⊂ {0, 1, 2}` such
   that `W0` is open in `A0` but not open in the whole space.
4. Construct a set `D0` of the particular-point space at `0` on `{0, 1, 2}`
   whose subspace topology is discrete (every subset of `D0` is open in it),
   with at least two points.
-/
import LeanCraftGame.Lib.Topology

namespace L67

-- the traces U ∩ A of the open sets U
def subspace {n : Nat} (T : Family n) (A : Finset (Fin n)) : Family n := sorry

-- W is open in the subspace A
def OpenIn {n : Nat} (T : Family n) (A W : Finset (Fin n)) : Prop := sorry

-- W0 is open in A0, but not open in the chain
def A0 : Finset (Fin 3) := sorry
def W0 : Finset (Fin 3) := sorry

-- a set with at least two points, discrete as a subspace of particularPoint 3 0
def D0 : Finset (Fin 3) := sorry

end L67
