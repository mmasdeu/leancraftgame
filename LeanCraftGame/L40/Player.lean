/-
# Subspaces and quotients

*Noor wants the subspaces of the plane catalogued. Sam's draft list has a line through
the origin, the two axes taken together, a parabola, and a line that misses `0`. Only
the first belongs on it.*

In Mathlib a subspace of `V` is a `Submodule K V`: as for the sub-objects of level 35, a
set (its `carrier`) bundled with the proofs that it is closed under the operations.

```lean
structure Submodule (R M : Type*) [Semiring R] [AddCommMonoid M] [Module R M] where
  carrier : Set M
  add_mem' : ∀ {a b}, a ∈ carrier → b ∈ carrier → a + b ∈ carrier
  zero_mem' : (0 : M) ∈ carrier
  smul_mem' : ∀ (c : R) {x}, x ∈ carrier → c • x ∈ carrier
```

Subspaces are ordered by inclusion, and Mathlib uses lattice notation for them:

* `⊥` is the zero subspace `{0}`, and `⊤` is the whole space;
* `U ⊓ W` is the intersection `U ∩ W`;
* `U ⊔ W` is the **smallest subspace containing both**, that is `U + W`. It is *not* the
  union: the union of two lines through `0` is not a subspace;
* `Submodule.span K s` is the smallest subspace containing the set `s`;
* `V ⧸ W` is the quotient space: vectors of `V`, where two vectors are identified when
  their difference lies in `W`.

The kernel `LinearMap.ker φ` of level 39 is a subspace, and it measures injectivity in
the sense of level 17: `φ` is injective exactly when `LinearMap.ker φ = ⊥`.

## Which sets are subspaces?

A line through the origin is a subspace of the plane. Many sets that look reasonable
are not: a line that misses `0`, a curve, the union of the two axes. To show that a set
is **not** a subspace, you give a counterexample to one of the three fields.

As in the previous level, the plane `ℚ²` is `Fin 2 → ℚ`, a vector is `![x, y]` and
its coordinates are `v 0` and `v 1`. A set is written with set-builder notation, such as
`{v | v 0 = 0}` (the vertical axis).

## Your task

1. `line`: the line through `0` of slope 2, `y = 2x`, as a set.
2. The axes `{v | v 0 * v 1 = 0}` are not a subspace: give two vectors `a`, `b` on the
   axes whose sum is not.
3. The parabola `{v | v 1 = v 0 ^ 2}` is not a subspace: give a point `p` on it such that
   `2 • p` (the point `![2 * p 0, 2 * p 1]`) is not on it.
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
