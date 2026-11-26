/-
# Metric spaces

MIL §11.2 works in a metric space: a type `X` with a distance `dist : X → X → ℝ`.

```lean
variable {X : Type*} [MetricSpace X] (a b c : X)
#check (dist a b : ℝ)
#check (dist_nonneg : 0 ≤ dist a b)
#check (dist_eq_zero : dist a b = 0 ↔ a = b)
#check (dist_comm a b : dist a b = dist b a)
#check (dist_triangle a b c : dist a c ≤ dist a b + dist b c)
```

From the distance come the open ball `Metric.ball x r = {y | dist y x < r}`, the closed
ball `Metric.closedBall x r = {y | dist y x ≤ r}`, Cauchy sequences, compactness, and
continuity in ε–δ form:

```lean
theorem Metric.continuous_iff {f : X → Y} :
    Continuous f ↔ ∀ b, ∀ ε > 0, ∃ δ > 0, ∀ a, dist a b < δ → dist (f a) (f b) < ε
```

The `δ` may depend on the point `b`. When one `δ` works for all points at once, `f` is
**uniformly continuous**: the quantifier `∃ δ` moves before `∀ b`. In Mathlib that is
`UniformContinuous f`, and its ε–δ form is `Metric.uniformContinuous_iff`.

## Part A: the axioms

The class `MetricSpace` bundles `dist` with its axioms. Write them yourself, for a
distance with values in `ℤ` (so that the referee can check examples on four points):
one field per axiom, after `dist`. The referee feeds your structure genuine metrics, which
must satisfy your axioms, and impostors, each of which must break at least one.

## Part B: uniform continuity

State `UnifCont f`: for every `ε > 0` there is `δ > 0` such that for all `x` and `y`,
`dist x y < δ` implies `dist (f x) (f y) < ε`. Write the quantifiers in this order.
-/
import Mathlib.Topology.MetricSpace.Pseudo.Defs

namespace L44

structure Metric' (α : Type) where
  dist : α → α → ℤ
  -- your axioms here

def UnifCont (f : ℝ → ℝ) : Prop := sorry

end L44
