/-
# Subspaces and quotients

*Noor wants a list of the subspaces of the plane. Sam's draft has a line through the
origin, the two axes together, a parabola, and a line that misses `0`.*

A subspace of `V` is a `Submodule K V`, with `K` and `V` as in level 39 (for the plane,
`ℚ` and `Fin 2 → ℚ`). Like the sub-objects of level 35, it's a set (its `carrier`)
bundled with proofs that it's closed under the operations. Roughly:

```lean
structure Submodule (K V : Type*) where
  carrier : Set V
  add_mem' : ∀ {a b}, a ∈ carrier → b ∈ carrier → a + b ∈ carrier
  zero_mem' : (0 : V) ∈ carrier
  smul_mem' : ∀ (c : K) {x}, x ∈ carrier → c • x ∈ carrier
```

Subspaces are ordered by inclusion, and Mathlib uses lattice notation for that order:

* `⊥` (type `\bot`) is the smallest subspace, and `⊤` (`\top`) the largest.
* `U ⊓ W` (`\sqcap`) is the largest subspace contained in both `U` and `W`.
* `U ⊔ W` (`\sqcup`) is the smallest subspace containing both.
* `V ⧸ W` is the quotient space: two vectors are identified when their difference lies
  in `W`.

## Which sets are subspaces?

To show that a set isn't a subspace, give a counterexample to one of the three fields.

As before, a vector is `![x, y]` with coordinates `v 0` and `v 1`. Write sets as
`{v | v 0 = 0}` (the vertical axis).

## Your task

1. `line`: the line through `0` of slope 2, `y = 2x`, as a set.
2. The axes `{v | v 0 * v 1 = 0}` aren't a subspace. Give two vectors `a`, `b` on the axes
   whose sum isn't.
3. The parabola `{v | v 1 = v 0 ^ 2}` isn't a subspace. Give a point `p` on it such that
   `2 • p` (the point `![2 * p 0, 2 * p 1]`) isn't on it.
4. Answer the questions below the lesson.
-/
import Mathlib.LinearAlgebra.Quotient.Defs

namespace L40

def line : Set (Fin 2 → ℚ) := sorry

def axes : Set (Fin 2 → ℚ) := {v | v 0 * v 1 = 0}
def a : Fin 2 → ℚ := sorry
def b : Fin 2 → ℚ := sorry

def parabola : Set (Fin 2 → ℚ) := {v | v 1 = v 0 ^ 2}
def p : Fin 2 → ℚ := sorry

def q1 : Fin 3 := sorry
def q2 : Fin 3 := sorry
def q3 : Bool := sorry

end L40
