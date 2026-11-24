/-
# Closed sets and closure

A set is **closed** when its complement is open. "Closed" is not the opposite
of "open": in a discrete space every set is both (**clopen**); in Sierpiński
space `{0}` is closed and not open, `{1}` is open and not closed, and `∅`,
`{0, 1}` are clopen.

Every set `A` sits between two canonical sets:

* the **interior** of `A`: the points `x` having an open `U` with
  `x ∈ U ⊆ A` (the largest open set inside `A`);
* the **closure** of `A`: the points `x` such that *every* open `U`
  containing `x` meets `A` (the smallest closed set containing `A`).

`A` is **dense** when its closure is the whole space. In Sierpiński space the
single point `1` is dense: its only neighbourhood-free competitor `0` has the
whole space as its only open neighbourhood, and that meets `{1}`. A point
whose closure is everything is called *generic*, and this is the reason
algebraic geometers care about Sierpiński space.

The closure operator is monotone (`A ⊆ B` gives `cl A ⊆ cl B`) and idempotent
(`cl (cl A) = cl A`): the referee checks both for your definition, on every
subset of a three-point space.

`IsOpen` is not needed: membership `U ∈ T` says that `U` is open.

## Your task

Define `IsClosed`, `interior`, `closure` (pointwise, as above) and `IsDense`.
-/
import LeanCraftGame.Lib.Topology

namespace L63

-- the complement of A is open
def IsClosed {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := sorry

-- the points x with some open U such that x ∈ U ⊆ A
def interior {n : Nat} (T : Family n) (A : Finset (Fin n)) : Finset (Fin n) := sorry

-- the points x such that every open U containing x meets A
def closure {n : Nat} (T : Family n) (A : Finset (Fin n)) : Finset (Fin n) := sorry

-- the closure of A is the whole space
def IsDense {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := sorry

end L63
