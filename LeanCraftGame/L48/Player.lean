/-
# Derivatives

*A new project: calculus. Noor wants the library to say things about the functions you
met in the Logic world, such as `x ↦ x² - 4x + 4`, whose root you found in level 9, and
`x ↦ min x 3`, which has a corner. Sam's first attempt already mixed up two arguments, so
read the signatures slowly.*

Mathlib has three ways to talk about the derivative of `f : ℝ → ℝ` at a point `x`:

```lean
deriv f x                  -- a real number: the derivative of f at x
HasDerivAt f f' x          -- a statement: f has derivative f' at x
DifferentiableAt ℝ f x     -- a statement: f is differentiable at x
```

* `deriv f x` is a **number**, so you can compute with it:
  `deriv (fun x : ℝ => x ^ 2) 3` is `6`.
* `HasDerivAt f f' x` is a **proposition**. Read the arguments in order: the function,
  then the derivative, then the point. `HasDerivAt (fun x : ℝ => x ^ 2) 6 3` says "the
  derivative of `x ↦ x²` at `3` is `6`"; Sam's `HasDerivAt (fun x : ℝ => x ^ 2) 3 6` says
  that the derivative at `6` is `3`, which is false.
* `DifferentiableAt ℝ f x` names the field `ℝ` explicitly, because Mathlib also
  differentiates over `ℂ`. On a set: `DifferentiableOn ℝ f s`, and `ContinuousOn f s`.

## A junk value

`deriv f x` is always defined, even where `f` has no derivative: then Mathlib sets it to
`0`. So `deriv (fun x : ℝ => |x|) 0 = 0`, although `|x|` has a corner at `0`, and
`deriv (fun x : ℝ => min x 3) 3 = 0` too. A genuine `0` looks the same: the derivative
`2x - 4` of `x² - 4x + 4` is `0` at its root `2`, where the graph is flat. This is the
same convention as `x / 0 = 0`: a total function is easier to use, and a theorem that
needs differentiability says so in a hypothesis.

## Intervals and "some point in between"

`Set.Icc a b` is the closed interval `[a, b]` and `Set.Ioo a b` the open interval
`(a, b)` (the letters say closed/open at each end). "There is a `c` in `(a, b)` with
`P c`" is written `∃ c ∈ Set.Ioo a b, P c`.

## Two theorems

**Rolle's theorem**, as Mathlib states it (`exists_deriv_eq_zero`):

> if `a < b`, `f` is continuous on `[a, b]` and `f a = f b`, then some `c ∈ (a, b)` has
> `deriv f c = 0`.

There is no differentiability hypothesis. At a point where `f` is not differentiable,
`deriv f c` is `0` anyway.

**The mean value theorem** (`exists_deriv_eq_slope`):

> if `a < b`, `f` is continuous on `[a, b]` and differentiable on `(a, b)`, then some
> `c ∈ (a, b)` has `deriv f c = (f b - f a) / (b - a)`.

Here differentiability is needed: without it, the junk value `0` would not be the slope.

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
