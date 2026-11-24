/-
# Neighbourhoods, filters and convergence

A set `A` is a **neighbourhood** of `x` when it contains an open set around
`x`: some open `U` with `x ∈ U ⊆ A`. The neighbourhoods of `x` form a family
`𝓝 x` with three properties:

* the whole space is in it, and `∅` is not;
* it is closed under finite intersections;
* it is upward closed: a superset of a neighbourhood is a neighbourhood.

A family with these properties is a (proper) **filter**. Filters are how
Mathlib speaks about limits: a sequence `u` **converges** to `x` when every
neighbourhood of `x` contains all the terms `u k` from some index on. In
Mathlib this is `Filter.Tendsto u Filter.atTop (𝓝 x)`, and the same
`Tendsto` covers `lim_{x→a} f x`, one-sided limits and limits at infinity,
by changing the filters. (Mathlib allows the improper filter containing `∅`,
the bottom `⊥`, so that filters form a complete lattice; the filters of this
level are proper.)

Without the Hausdorff property limits misbehave. In Sierpiński space the only
neighbourhood of `0` is the whole space, so *every* sequence converges to
`0`, and the constant sequence `1, 1, 1, …` has two limits. In a Hausdorff
space a sequence has at most one limit.

A sequence in a finite space is a function `u : ℕ → Fin n`.

## Your task

1. Define `nbhds T x`, the family of neighbourhoods of `x`.
2. Define `IsFilter F`, a proper filter on `Fin n`.
3. Define `Converges T u x` with open sets: every open set containing `x`
   contains all the terms from some index on. (With neighbourhoods instead of
   open sets the definition is equivalent, but the referee would have to
   prove the equivalence on every test; open sets keep its job finite.)
4. Construct `twoLimits`, a sequence in Sierpiński space that converges to
   both points, and that is **not** constant.
-/
import LeanCraftGame.Lib.Topology

namespace L72

-- the sets A containing an open U with x ∈ U ⊆ A
def nbhds {n : Nat} (T : Family n) (x : Fin n) : Family n := sorry

-- contains the whole space, not ∅, upward closed, closed under ∩
def IsFilter {n : Nat} (F : Family n) : Prop := sorry

-- every open set containing x contains all the terms from some index on
def Converges {n : Nat} (T : Family n) (u : ℕ → Fin n) (x : Fin n) : Prop := sorry

-- a non-constant sequence converging to both 0 and 1 in Sierpiński space
def twoLimits : ℕ → Fin 2 := sorry

end L72
