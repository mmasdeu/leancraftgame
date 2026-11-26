/- Hidden test battery for Level 50: Integrals and measures. -/
import LeanCraftGame.Referee
import LeanCraftGame.L50.Player

#no_sorry L50.I2
#no_sorry L50.vol
#no_sorry L50.ftc
#no_sorry L50.q1
#no_sorry L50.q2
#no_sorry L50.q3
#level_start "Integrals and measures"

#expect_false "In Mathlib, ∫ x in (1:ℝ)..0, x = 1 / 2" :
  ∫ x in (1:ℝ)..0, x = 1 / 2
#expect_true "I2 is the integral of x² from 0 to 1" unfolding L50.I2 :
  L50.I2 = 1 / 3
#expect_true "vol is the length of [0, 2]" unfolding L50.vol :
  L50.vol = 2
#expect_equiv "ftc is the fundamental theorem of calculus" :
  L50.ftc ↔ ∀ (f f' : ℝ → ℝ) (a b : ℝ), (∀ x ∈ Set.uIcc a b, HasDerivAt f (f' x) x) →
    IntervalIntegrable f' MeasureTheory.volume a b → ∫ y in a..b, f' y = f b - f a
  using fun _ _ _ _ => intervalIntegral.integral_eq_sub_of_hasDerivAt
#expect_choice "Question 1: integrals that diverge" : L50.q1 = false
#expect_choice "Question 2: what ∀ᵐ means" : L50.q2 = 1
#expect_choice "Question 3: the domination hypothesis" : L50.q3 = 2

#level_report
