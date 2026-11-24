/-
# The definition of a topology

A **topology** on a set `X` is a family of subsets, the *open sets*, such that

* `∅` and `X` are open,
* any union of open sets is open,
* the intersection of two open sets is open.

Why unions of *any* size but intersections of only *two* (hence finitely
many)? Think of `ℝ`: the open intervals `(-1/n, 1/n)` are open, and their
intersection over all `n ≥ 1` is `{0}`, which is not. Asking for arbitrary
intersections would rule out the usual topology of the line.

In Lean, a structure bundles the data with its axioms. For an arbitrary type
the pedagogical version reads

```lean
structure MyTopology (X : Type) where
  IsOpen : Set X → Prop
  isOpen_univ : IsOpen Set.univ
  isOpen_inter : ∀ s t, IsOpen s → IsOpen t → IsOpen (s ∩ t)
  isOpen_sUnion : ∀ S : Set (Set X), (∀ s ∈ S, IsOpen s) → IsOpen (⋃₀ S)
```

and Mathlib's `TopologicalSpace X` is exactly this structure (`∅` is the
union of the empty family, so it needs no axiom of its own). On a finite set
every union is a finite union, so for `Fin n` it is enough to ask for `∅`,
the whole space, and *binary* unions and intersections.

## Your task: repair a colleague's structure

A colleague wrote the structure below for topologies on `Fin n`, and it
accepts families that are not topologies. Repair it: keep `opens` as the
first field, and change or add axioms (one field per axiom). The referee
feeds your structure the standard examples, which must be accepted, and
some impostors, which must be ruled out by at least one of your axioms.
-/
import LeanCraftGame.Lib.Topology

namespace L61

structure FinTopology (n : Nat) where
  opens : Family n
  empty_mem : ∅ ∈ opens
  union_mem : ∀ U ∈ opens, ∀ V ∈ opens, U ∪ V ∈ opens

end L61
