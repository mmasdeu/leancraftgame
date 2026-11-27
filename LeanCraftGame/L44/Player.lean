/-
# Metric spaces

*`Tendsto s atTop (𝓝 a)` is your `ConvergesTo` with `dist` in place of `|s n - a|`. Noor
wants that to work wherever there's a distance. First the library has to say what a
distance is.*

A **metric space** is a type `X` with a distance `dist : X → X → ℝ`:

```lean
variable {X : Type*} [MetricSpace X] (a b c : X)
#check (dist a b : ℝ)
#check (dist_nonneg : 0 ≤ dist a b)
#check (dist_eq_zero : dist a b = 0 ↔ a = b)
#check (dist_comm a b : dist a b = dist b a)
#check (dist_triangle a b c : dist a c ≤ dist a b + dist b c)
```

The distance gives balls (`Metric.ball x r = {y | dist y x < r}`, and `Metric.closedBall`
with `≤`), Cauchy sequences, compactness, and continuity in ε–δ form:

```lean
theorem Metric.continuous_iff {f : X → Y} :
    Continuous f ↔ ∀ b, ∀ ε > 0, ∃ δ > 0, ∀ a, dist a b < δ → dist (f a) (f b) < ε
```

Here `δ` may depend on `b`. If one `δ` works for all points, `f` is uniformly continuous:
`∃ δ` moves before `∀ b`. Mathlib calls it `UniformContinuous f` (ε–δ form:
`Metric.uniformContinuous_iff`). It's the quantifier swap of level 10 again.

## Part A: the axioms

`MetricSpace` bundles `dist` with its axioms. Write them yourself, one field per axiom
after `dist`, for a distance with values in `ℤ` so the referee can test four points. Real
metrics must satisfy your axioms, and each impostor must break one. Sam's first draft let
`dist a b = a - b` through, since it does satisfy `dist a b = 0 ↔ a = b`.

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
