/-
# Metric spaces

*`Tendsto s atTop (𝓝 a)` is your `ConvergesTo` with `dist` in place of `|s n - a|`. To
use it on other spaces, the library first has to say what a distance is.*

A **metric space** is a type `X` with a distance `dist : X → X → ℝ`. Mathlib's axioms:

```lean
variable {X : Type*} [MetricSpace X] (a b c : X)
#check (dist a b : ℝ)
#check (dist_nonneg : 0 ≤ dist a b)
#check (dist_eq_zero : dist a b = 0 ↔ a = b)
#check (dist_comm a b : dist a b = dist b a)
#check (dist_triangle a b c : dist a c ≤ dist a b + dist b c)
```

On `ℝ`, `dist x y` is `|x - y|`. The distance gives continuity in ε–δ form: `f` is
continuous when

```lean
∀ b, ∀ ε > 0, ∃ δ > 0, ∀ a, dist a b < δ → dist (f a) (f b) < ε
```

Here `δ` may depend on `b`. If one `δ` works for all points, `f` is **uniformly
continuous**: `∃ δ` moves before `∀ b`. It's the quantifier order of level 10 again.

## Part A: the axioms

Write the axioms yourself as fields of `Metric'`, one field per axiom after `dist`, each
with its own `∀`. The distance takes values in `ℤ` so the referee can test it on four
points. Real metrics must satisfy your axioms, and each impostor must break one. Sam's
first draft let `dist a b = a - b` through, since it does satisfy `dist a b = 0 ↔ a = b`.

## Part B: uniform continuity

State `UnifCont f`: for every `ε > 0` there is `δ > 0` such that for all `x` and `y`,
`dist x y < δ` implies `dist (f x) (f y) < ε`. Write the quantifiers in this order.
-/
import Mathlib.Topology.MetricSpace.Pseudo.Defs

namespace L38

structure Metric' (α : Type) where
  dist : α → α → ℤ
  -- your axioms here

def UnifCont (f : ℝ → ℝ) : Prop := sorry

end L38
