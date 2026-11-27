/-
# Integrals and measures

*The last project before the audit: integrals. Noor wants two theorems in the library.
The fundamental theorem of calculus ties integrals to the `HasDerivAt` of the last world;
dominated convergence speaks of limits, with the filters of the Topology world.*

Mathlib's **interval integral** works like the integral of a first calculus course:

```lean
∫ x in a..b, f x        -- the integral of f from a to b
∫ x in (0:ℝ)..1, x ^ 2  -- = 1 / 3
```

* `∫ x in a..b, f x` is a real number. The `x` is a bound variable, like the `x` of
  `fun x => …`. The type annotation `(0:ℝ)` tells Lean that the bounds are reals.
* When `b < a` it is **oriented**: `∫ x in b..a, f x = -∫ x in a..b, f x`.
* Like `deriv` in level 48, it is a total function. If `f` is not integrable, the integral is `0`.

## The fundamental theorem of calculus

Mathlib's version (`intervalIntegral.integral_eq_sub_of_hasDerivAt`), for `f f' : ℝ → ℝ`:

> if `f` has derivative `f' x` at every `x` of `Set.uIcc a b` (the interval between `a`
> and `b`, in either order), and `f'` is integrable on it, then
> `∫ y in a..b, f' y = f b - f a`.

"`f'` is integrable between `a` and `b`" is written
`IntervalIntegrable f' MeasureTheory.volume a b`.

## Measures

Behind the interval integral is a **measure**. On `ℝ` the measure is
`MeasureTheory.volume`, the length: `volume (Set.Icc a b)` is `b - a`. Measures take
values in `ENNReal`, the numbers in `[0, ∞]`, since a set may have infinite measure.

* `MeasurableSet s`: `s` is one of the sets the measure is defined on.
* `∀ᵐ x ∂μ, P x`: `P x` holds for **almost every** `x`, that is, the set where it fails
  has measure `0`. It is a filter statement, `∀ᶠ x in ae μ, P x`, like the "eventually"
  of level 43.
* `∫ x, f x ∂μ`: the integral of `f` over the whole space with respect to `μ`.

The great theorem of the subject is **dominated convergence**: under a bound, the limit of
the integrals is the integral of the limit. Read the `Tendsto` lines as in level 43.
Here is Mathlib's statement, `MeasureTheory.tendsto_integral_of_dominated_convergence`,
slightly shortened:

```lean
theorem tendsto_integral_of_dominated_convergence {F : ℕ → α → ℝ} {f : α → ℝ}
    (bound : α → ℝ)
    (F_measurable : ∀ n, AEStronglyMeasurable (F n) μ)
    (bound_integrable : Integrable bound μ)
    (h_bound : ∀ n, ∀ᵐ a ∂μ, ‖F n a‖ ≤ bound a)
    (h_lim : ∀ᵐ a ∂μ, Tendsto (fun n => F n a) atTop (𝓝 (f a))) :
    Tendsto (fun n => ∫ a, F n a ∂μ) atTop (𝓝 (∫ a, f a ∂μ))
```

## Your task

1. `I2`: the integral of `x ↦ x²` from `0` to `1`, written with `∫`.
2. `vol`: the measure (`MeasureTheory.volume`) of the closed interval `[0, 2]` of `ℝ`.
3. `ftc`: the fundamental theorem of calculus as above, with the binders in this order:
   `(f f' : ℝ → ℝ) (a b : ℝ)`, the derivative hypothesis, the integrability hypothesis.
4. Answer the questions below the lesson.
-/
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral.FundThmCalculus

namespace L50

def I2 : ℝ := sorry

def vol : ENNReal := sorry

statement ftc : sorry

def q1 : Bool := sorry
def q2 : Fin 4 := sorry
def q3 : Fin 4 := sorry

end L50
