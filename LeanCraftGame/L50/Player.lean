/-
# Integrals and measures

*The last project before the audit: integrals. Noor wants the fundamental theorem of
calculus in the library, and everyone able to read Mathlib's dominated convergence.*

Mathlib's **interval integral** is the integral of a first calculus course:

```lean
∫ x in a..b, f x        -- the integral of f from a to b
∫ x in (0:ℝ)..1, x ^ 2  -- = 1 / 3
```

* `∫ x in a..b, f x` is a real number. The `x` is bound, like in `fun x => …`. The
  `(0:ℝ)` tells Lean the bounds are reals.
* It's oriented: `∫ x in b..a, f x = -∫ x in a..b, f x`.
* Like `deriv`, it's a total function, with a junk value where there's no honest answer.

## The fundamental theorem of calculus

Mathlib's version (`intervalIntegral.integral_eq_sub_of_hasDerivAt`), for `f f' : ℝ → ℝ`:

> if `f` has derivative `f' x` at every `x` of `Set.uIcc a b` (the interval between `a`
> and `b`, in either order), and `f'` is integrable on it, then
> `∫ y in a..b, f' y = f b - f a`.

"`f'` is integrable between `a` and `b`" is
`IntervalIntegrable f' MeasureTheory.volume a b`.

## Measures

Behind the integral is a **measure**. On `ℝ` it's `MeasureTheory.volume`, the length.
Measures take values in `ENNReal`, the numbers in `[0, ∞]`, since a set can have infinite
measure. So `volume (Set.Icc a b)` is the real `b - a` turned into an `ENNReal`,
`ENNReal.ofReal (b - a)`. A numeral such as `2` can be written directly as an `ENNReal`.

* `MeasurableSet s`: `s` is one of the sets the measure is defined on.
* `∀ᵐ x ∂μ, P x`: `P x` holds for almost every `x` (`∂μ` reads "with respect to `μ`").
  It's the filter statement `∀ᶠ x in ae μ, P x`, like "eventually" in level 43. The
  filter `ae μ` holds the sets whose complement has measure `0`.
* `∫ x, f x ∂μ`: the integral of `f` over the whole space with respect to `μ`.

**Dominated convergence** says that under a bound, the limit of the integrals is the
integral of the limit. Read the `Tendsto` lines as in level 43. Here is
`MeasureTheory.tendsto_integral_of_dominated_convergence`, slightly shortened:

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
2. `vol`: the measure of the closed interval `[0, 2]` of `ℝ`, written with
   `MeasureTheory.volume`.
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
