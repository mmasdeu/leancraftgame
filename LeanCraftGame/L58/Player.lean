/-
# Sets and maps

Topology is written in the language of sets: open sets, their unions and
intersections, and above all **inverse images**. This first level of the
Topology World sets up that language on finite sets, where the referee can
check everything by computation.

The points are `Fin n = {0, 1, …, n-1}` and a subset is a `Finset (Fin n)`:
`{0, 2}`, `∅`, `Finset.univ` (all of `Fin n`). The operations are `A ∪ B`,
`A ∩ B`, `Aᶜ` (complement) and `A ⊆ B`. A map is a function
`f : Fin m → Fin n`; `![1, 1, 0]` is the map `0 ↦ 1, 1 ↦ 1, 2 ↦ 0`.

`Finset.univ.filter (fun x => P x)` is the set of the points `x` with
`P x`: the finite version of `{x | P x}`.

## Inverse images behave, direct images do not

For every map `f`, the inverse image `f⁻¹(V) = {x | f x ∈ V}` commutes with
everything: `f⁻¹(V ∩ W) = f⁻¹(V) ∩ f⁻¹(W)`, and likewise for unions and
complements. The direct image `f(A) = {f x | x ∈ A}` commutes with unions,
but **not** with intersections: `f(A ∩ B) ⊆ f(A) ∩ f(B)`, and the inclusion
can be strict. This asymmetry is why continuity will be defined with inverse
images.

## Your task

1. Define `Disj A B`: `A` and `B` have no point in common.
2. Define `pre f V`, the inverse image.
3. Construct a counterexample to `f(A ∩ B) = f(A) ∩ f(B)`: a map `f0` and two
   sets `A0`, `B0`. (`img` is written for you.)

The referee then checks that your `pre` commutes with `∩` and `∪`, for every
pair of subsets.
-/
import LeanCraftGame.Lib.Topology

namespace L58

-- A and B have no point in common
def Disj {n : Nat} (A B : Finset (Fin n)) : Prop := sorry

-- the inverse image of V: the points that f sends into V
def pre {m n : Nat} (f : Fin m → Fin n) (V : Finset (Fin n)) : Finset (Fin m) := sorry

-- the direct image of A (given)
def img {m n : Nat} (f : Fin m → Fin n) (A : Finset (Fin m)) : Finset (Fin n) :=
  Finset.univ.filter (fun y => ∃ x ∈ A, f x = y)

-- a map and two sets with img f0 (A0 ∩ B0) ≠ img f0 A0 ∩ img f0 B0
def f0 : Fin 2 → Fin 2 := sorry
def A0 : Finset (Fin 2) := sorry
def B0 : Finset (Fin 2) := sorry

end L58
