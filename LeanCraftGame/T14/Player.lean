/-

# Separation axioms

`T0` says that any two distinct points are distinguished by some open set in at
least one direction. `T1` lets you choose an open set containing the first point
and omitting the second; equivalently singletons are closed. Hausdorff (`T2`)
strengthens this to disjoint open neighbourhoods.

Thus Hausdorff implies `T1`, and `T1` implies `T0`. Sierpiński space is `T0`
but not `T1`. An infinite cofinite space is `T1` but not Hausdorff: nonempty
open sets always intersect. Those infinite claims use general instances and
proofs, not finite enumeration.

**ACT III — TOPOLOGY**

The earlier acts gave you the vocabulary needed here: functions and quantifiers from
**sequences**, inverse images and local approximation from **limits**, and packaged
axioms from **structures**. This level turns those tools toward general spaces.

## The road from here

Finish the course by expressing convergence with neighbourhoods and filters.


## Your tasks

Define `MyT0`, `MyT1`, and `MyHausdorff` with open sets and explicit
point/neighbourhood conditions. Use `U ∩ V = ∅` for disjoint neighbourhoods.
-/
namespace T14

open LeanCraftGame.Topology

def MyT0 {α : Type*} (τ : MyTopology α) : Prop := sorry

def MyT1 {α : Type*} (τ : MyTopology α) : Prop := sorry

def MyHausdorff {α : Type*} (τ : MyTopology α) : Prop := sorry

end T14
