/-
# Metric spaces

*`Tendsto s atTop (𝓝 a)` is your `ConvergesTo` with `dist` in place of `|s n - a|`. Noor
wants that to work wherever there is a distance: points, functions, words. First the
library has to say what a distance is.*

A **metric space** is a type `X` with a distance `dist : X → X → ℝ`:

```lean
variable {X : Type*} [MetricSpace X] (a b c : X)
#check (dist a b : ℝ)
#check (dist_nonneg : 0 ≤ dist a b)
#check (dist_eq_zero : dist a b = 0 ↔ a = b)
#check (dist_comm a b : dist a b = dist b a)
#check (dist_triangle a b c : dist a c ≤ dist a b + dist b c)
```

The distance gives the open ball `Metric.ball x r = {y | dist y x < r}`, the closed ball
`Metric.closedBall x r = {y | dist y x ≤ r}`, Cauchy sequences, compactness, and continuity
in ε–δ form:

```lean
theorem Metric.continuous_iff {f : X → Y} :
    Continuous f ↔ ∀ b, ∀ ε > 0, ∃ δ > 0, ∀ a, dist a b < δ → dist (f a) (f b) < ε
```

Here `δ` may depend on the point `b`. If one `δ` works for all points at once, `f` is
uniformly continuous, and `∃ δ` moves before `∀ b`. In Mathlib that's
`UniformContinuous f`, with ε–δ form `Metric.uniformContinuous_iff`. It's the quantifier
swap of level 10 again, where "every term is below some `M`" was not "bounded".

## Part A: the axioms

The class `MetricSpace` bundles `dist` with its axioms. Write them yourself, for a
distance with values in `ℤ` (so the referee can check examples on four points). Add one
field per axiom, after `dist`. The referee feeds your structure real metrics, which must
satisfy your axioms, and impostors, which must each break at least one. Sam's first draft
let `dist a b = a - b` through. It does satisfy `dist a b = 0 ↔ a = b`, so a distance
needs more than that.

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
