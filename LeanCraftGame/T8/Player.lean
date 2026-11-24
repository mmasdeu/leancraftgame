/-
# Continuous maps

A function `f : α → β` is continuous when the inverse image of every open set
is open. For `s : Set β`, the inverse image `f ⁻¹' s` consists of the points
`x : α` for which `f x ∈ s`.

This is a condition on **inverse** images. Requiring open direct images instead
defines an open map, which is a different property.

The shared `MyTopology` layer converts to Mathlib's `TopologicalSpace`; after
this lesson, `myContinuous_iff_continuous` identifies your predicate with
Mathlib's `Continuous`.

Constant maps show the distinction: `false` from discrete `Bool` to Sierpiński
space is continuous, but not open, because it sends the open singleton `{true}`
to the non-open singleton `{false}`.

## Your tasks

Define `MyContinuous τs τt f` using inverse images of open sets. Also define
`MyOpenMap` using direct images, and set `continuousNotOpenMap` to be constantly
`false` on `Bool`.
-/
namespace T8

open LeanCraftGame.Topology

def MyContinuous {α β : Type*} (τs : MyTopology α) (τt : MyTopology β)
    (f : α → β) : Prop := sorry

def MyOpenMap {α β : Type*} (τs : MyTopology α) (τt : MyTopology β)
    (f : α → β) : Prop := sorry

def continuousNotOpenMap : Bool → Bool := sorry

end T8
