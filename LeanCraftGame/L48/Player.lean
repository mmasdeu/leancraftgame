/-
# Derivatives

*New project: calculus. Noor wants the library to handle functions like `x ↦ x² - 4x + 4`
from level 9 and `x ↦ min x 3`, which has a corner. Sam's first attempt already mixed up
two arguments, so read the signatures slowly.*

Mathlib has three ways to talk about the derivative of `f : ℝ → ℝ` at `x`:

```lean
deriv f x                  -- a real number: the derivative of f at x
HasDerivAt f f' x          -- a statement: f has derivative f' at x
DifferentiableAt ℝ f x     -- a statement: f is differentiable at x
```

* `deriv f x` is a number you can compute with: `deriv (fun x : ℝ => x ^ 2) 3` is `6`.
* `HasDerivAt f f' x` takes the function, then the derivative, then the point.
  `HasDerivAt (fun x : ℝ => x ^ 2) 6 3` says the derivative at `3` is `6`. Sam's
  `HasDerivAt (fun x : ℝ => x ^ 2) 3 6` says the derivative at `6` is `3`, which is false.
* `DifferentiableAt ℝ f x` names `ℝ` because Mathlib also differentiates over `ℂ`. On a
  set, use `DifferentiableOn ℝ f s` and `ContinuousOn f s`.

## A junk value

`deriv f x` is always defined. Where `f` has no derivative, it's `0`. So
`deriv (fun x : ℝ => |x|) 0 = 0` and `deriv (fun x : ℝ => min x 3) 3 = 0`, despite the
corners. A real `0` looks the same: `x² - 4x + 4` has derivative `0` at `2`, where the
graph is flat. It's the convention of `x / 0 = 0`. Theorems that need differentiability
say so in a hypothesis.

## Intervals

`Set.Icc a b` is `[a, b]` and `Set.Ioo a b` is `(a, b)` (closed or open at each end).
"Some `c` in `(a, b)` has `P c`" is `∃ c ∈ Set.Ioo a b, P c`.

## Two theorems

**Rolle's theorem** (`exists_deriv_eq_zero`):

> if `a < b`, `f` is continuous on `[a, b]` and `f a = f b`, then some `c ∈ (a, b)` has
> `deriv f c = 0`.

It needs no differentiability: where `f` isn't differentiable, `deriv f c` is `0` anyway.

**The mean value theorem** (`exists_deriv_eq_slope`):

> if `a < b`, `f` is continuous on `[a, b]` and differentiable on `(a, b)`, then some
> `c ∈ (a, b)` has `deriv f c = (f b - f a) / (b - a)`.

Here differentiability is needed, or the junk `0` would pass for the slope.

## Your task

1. `d3`: the derivative of `x ↦ x³` at `2`, written with `deriv`.
2. `sq_hasDeriv`: the statement "`x ↦ x²` has derivative `6` at `3`", with `HasDerivAt`.
3. `rolle`: Rolle's theorem as above, with the variables and hypotheses in this order:
   `(f : ℝ → ℝ) (a b : ℝ)`, then `a < b`, continuity on `[a, b]`, `f a = f b`.
4. `mvt`: the mean value theorem, in the order `(f : ℝ → ℝ) (a b : ℝ)`, `a < b`,
   continuity on `[a, b]`, differentiability on `(a, b)`.
5. Answer the two questions below the lesson.
-/
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.Deriv.Abs
import Mathlib.Analysis.Calculus.LocalExtr.Rolle
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.Deriv.MeanValue

namespace L48

def d3 : ℝ := sorry

statement sq_hasDeriv : sorry

statement rolle : sorry

statement mvt : sorry

def q1 : Fin 4 := sorry
def q2 : Bool := sorry

end L48
