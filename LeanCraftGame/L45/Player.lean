/-
# Topological spaces

*Some spaces Noor needs have no sensible distance. Mathlib's most general notion of space
keeps only the open sets, which is too abstract to test on `ℝ`. So the Annex builds a
gallery of tiny spaces, where the referee can check every open set.*

A **topology** on a type `X` says which subsets are *open*:

```lean
class TopologicalSpace (X : Type u) where
  IsOpen : Set X → Prop
  isOpen_univ : IsOpen Set.univ
  isOpen_inter : ∀ s t, IsOpen s → IsOpen t → IsOpen (s ∩ t)
  isOpen_sUnion : ∀ S : Set (Set X), (∀ t ∈ S, IsOpen t) → IsOpen (⋃₀ S)
```

The whole space is open, the intersection of *two* open sets is open, and the union of
*any* family of open sets is open (`∅` is the union of the empty family). A map is
continuous when the preimage of every open set is open (the `f ⁻¹' s` of level 16):

```lean
theorem continuous_def {f : X → Y} : Continuous f ↔ ∀ s, IsOpen s → IsOpen (f ⁻¹' s)
```

Preimage, not image. Asking that `f '' U` be open for every open `U` gives a different
notion, an *open map*.

## Finite spaces

The referee can't list the open sets of `ℝ`, but on a finite set it can check everything.
So this level works on `Fin n = {0, 1, …, n-1}`. A subset is a `Finset (Fin n)`, and a
family of subsets is a `Family n := Finset (Finset (Fin n))`. On a finite set every union
is finite, so the axioms only need `∅`, the whole set `Finset.univ`, and *binary* unions
and intersections.

Two spaces worth knowing:

* **Sierpiński space**: two points `0` and `1`, open sets `∅`, `{1}`, `{0, 1}`.
* the **particular-point topology** at `p`: the open sets are `∅` and every set
  containing `p`.

Write a family like a set: `({∅, {1}, Finset.univ} : Family 2)`. The library also has the
discrete space `Top.discrete n` (every set is open), the indiscrete space
`Top.indiscrete n` (only `∅` and everything), and the preimage
`Top.Ref.pre f V = {x | f x ∈ V}`.

## Your task

1. Give `FinTopology` its axioms, one field per axiom, after `opens`.
2. Define Sierpiński space and the particular-point topology.
3. Define continuity, with preimages (`Top.Ref.pre f V`).
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
