/-
# Sets and operations (vertical placeholder)

A subset of `α` has type `Set α`, and `x ∈ s` says that `x` belongs to `s`.
Two sets are **disjoint** when no element belongs to both.

This first topology placeholder checks that prefixed levels work in every part
of the game. The remaining T1 exercises are specified in
`docs/topology-curriculum.md` and arrive with the foundations milestone.

## Your task

Define `MyDisjoint s t` without using Mathlib's lattice predicate `Disjoint`.
-/
namespace T1

def MyDisjoint {α : Type*} (s t : Set α) : Prop := sorry

end T1
