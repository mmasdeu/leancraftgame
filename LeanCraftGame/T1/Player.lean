/-
# Sets and operations

A subset of `α` has type `Set α`, and `x ∈ s` says that `x` belongs to `s`.
Two sets are **disjoint** when no element belongs to both. A family `C : Set (Set α)`
**covers** `s` when every element of `s` belongs to some member of `C`.

Inverse images respect both unions and intersections. Direct images respect
unions, but need not respect intersections: a constant map is already enough
to see the problem.

## Your tasks

1. Define `MyDisjoint s t` without using Mathlib's lattice predicate `Disjoint`.
2. Define `IsCover s C` using an existential open-family witness for every `x ∈ s`.
3. Define `PreimagesPreserveOperations f`, requiring the preimage of both a
   union and an intersection of any two sets to equal the corresponding operation.
4. Define `DirectImagesPreserveIntersections f` analogously, and supply a
   `counterexampleMap : Bool → Bool` for which that statement is false.
-/
namespace T1

def MyDisjoint {α : Type*} (s t : Set α) : Prop := sorry

def IsCover {α : Type*} (s : Set α) (C : Set (Set α)) : Prop := sorry

def PreimagesPreserveOperations {α β : Type*} (f : α → β) : Prop := sorry

def DirectImagesPreserveIntersections {α β : Type*} (f : α → β) : Prop := sorry

def counterexampleMap : Bool → Bool := sorry

end T1
