/-
# Topological spaces

*Some spaces Noor needs have no sensible distance. Mathlib's most general notion of space
keeps only the open sets. That's hard to test on `ℝ`, so the Annex builds a gallery of
tiny spaces where the referee can check every open set.*

A **topology** on a type `X` says which subsets are *open*:

```lean
class TopologicalSpace (X : Type u) where
  IsOpen : Set X → Prop
  isOpen_univ : IsOpen Set.univ
  isOpen_inter : ∀ s t, IsOpen s → IsOpen t → IsOpen (s ∩ t)
  isOpen_sUnion : ∀ S : Set (Set X), (∀ t ∈ S, IsOpen t) → IsOpen (⋃₀ S)
```

The whole space is open, the intersection of *two* open sets is open, and the union of
*any* family of open sets is open (`∅` is the empty union). A map `f : X → Y` between two
spaces is **continuous** when the preimage of every open set of `Y` is open in `X` (the
`f ⁻¹' s` of level 16). Preimage, not image.

## Finite spaces

This level works on `Fin n = {0, 1, …, n-1}`. A subset is a `Finset (Fin n)`, and a family
of subsets is a `Family n`, short for `Finset (Finset (Fin n))`. Every union is finite
here, so the axioms only need `∅`, `Finset.univ`, and unions and intersections of *two*
open sets.

Two spaces worth knowing:

* **Sierpiński space**: two points `0` and `1`, open sets `∅`, `{1}`, `{0, 1}`.
* the **particular-point topology** at `p`: the open sets are `∅` and every set
  containing `p`.

Write a family like a set: `({∅, {1}, Finset.univ} : Family 2)`. The library also has
`Top.discrete n` (every set open) and `Top.Ref.pre f V`, the preimage of `V` as a `Finset`
(the finite `f ⁻¹' V`). `∀ U ∈ T, P U` means "every `U` in `T` has `P U`".

## Your task

1. Give `FinTopology` its axioms, one field per axiom, after `opens`: `∅` and
   `Finset.univ` are open, and for open `U` and `V`, so are `U ∩ V` and `U ∪ V`.
2. Define Sierpiński space and the particular-point topology.
3. Define `IsCont T S f` for `f` from `Fin m` with topology `T` to `Fin n` with topology
   `S`, with preimages (`Top.Ref.pre f V`).
-/
import LeanCraftGame.Lib.Topology

namespace L45

structure FinTopology (n : Nat) where
  opens : Family n
  -- your axioms here, for example `empty_mem : ∅ ∈ opens`

-- the open sets of Sierpiński space
def mySierpinski : Family 2 := sorry

-- ∅, and every subset of Fin n that contains p
def myParticular (n : Nat) (p : Fin n) : Family n := sorry

-- the preimage under f of every S-open set is T-open
def IsCont {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop := sorry

end L45
