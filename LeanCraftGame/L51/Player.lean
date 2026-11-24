/-
# Metric spaces

A **metric** on `α` is a distance `d : α → α → ℝ` such that

* `d x y = 0` exactly when `x = y`,
* `d x y ≥ 0`,
* `d x y = d y x`,
* `d x z ≤ d x y + d y z` (the triangle inequality).

Here the distances are integers, so that the referee can compute. Examples
and non-examples:

* `|x - y|` on `ℤ`, the discrete metric (`0` or `1`), the `ℓ¹` and `ℓ^∞`
  distances on `ℤ²`;
* the **`p`-adic distance** on `ℤ` is a metric too (with real values), and it
  satisfies the strong triangle inequality `d(x, z) ≤ max(d(x, y), d(y, z))`;
* `(x - y)²` is not a metric: `0, 1, 2` violate the triangle inequality.

The non-negativity axiom is a consequence of the others (take `z = x` in
the triangle inequality), but it does no harm to state it. Redundant axioms
cost nothing; missing ones let junk in.

Every metric space is a topological space, with the open balls as a basis:
that is how the `ε`'s of the Analysis world fit into the Topology world.

## Your task

Write the four axioms of a metric, in the order listed above. The first one is
a single `↔` statement (type it `\iff`); `≤` is `\le`.

The referee tests your structure on genuine distances (`|x - y|`, the
distance that is `0` for equal points and `1` for different ones...) and on
imposters (`x - y`, `(x - y)^2`, ...). Each of your axioms must be true for
the first kind, and the imposters must each fail at least one of them.

Think about what each imposter gets wrong.
-/
namespace L51

structure Metric' (α : Type) where
  dist : α → α → ℤ
  eq_zero : sorry
  nonneg : sorry
  symm : sorry
  triangle : sorry

end L51
