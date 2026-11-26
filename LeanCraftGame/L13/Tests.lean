/- Hidden test battery for Level 13: Be the referee. -/
import LeanCraftGame.Referee
import LeanCraftGame.L13.Player

namespace L13Ref
def ConvergesTo0 (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n| < ε
-- The mutants. MutNonneg is stronger than convergence; MutFrequently, MutEventuallySmall
-- and MutNoAbs are weaker; MutDecreasing is neither.
def MutNonneg (s : ℕ → ℝ) : Prop := (∀ n, 0 ≤ s n) ∧ ∀ ε > 0, ∃ N, ∀ n ≥ N, s n < ε
def MutFrequently (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∀ N, ∃ n ≥ N, |s n| < ε
def MutEventuallySmall (s : ℕ → ℝ) : Prop := ∃ N, ∀ n ≥ N, |s n| < 1
def MutNoAbs (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, s n < ε
def MutDecreasing (s : ℕ → ℝ) : Prop := (∀ n, s (n + 1) ≤ s n) ∧ ∀ ε > 0, ∃ n, |s n| < ε
end L13Ref

#no_sorry L13.good₁
#no_sorry L13.good₂
#no_sorry L13.bad₁
#no_sorry L13.bad₂
#level_start "Be the referee"

#expect_true "good₁ converges to 0" unfolding L13Ref.ConvergesTo0 L13.good₁ :
  L13Ref.ConvergesTo0 L13.good₁
#expect_true "good₂ converges to 0" unfolding L13Ref.ConvergesTo0 L13.good₂ :
  L13Ref.ConvergesTo0 L13.good₂
#expect_true "bad₁ does not converge to 0" unfolding L13Ref.ConvergesTo0 L13.bad₁ :
  ¬ L13Ref.ConvergesTo0 L13.bad₁
#expect_true "bad₂ does not converge to 0" unfolding L13Ref.ConvergesTo0 L13.bad₂ :
  ¬ L13Ref.ConvergesTo0 L13.bad₂

-- A stronger mutant can only be caught by a good sequence it rejects, a weaker one only by a
-- bad sequence it accepts: only that half is stated (the labels are tested above).
#expect_caught "mutant `(∀ n, 0 ≤ s n) ∧ ∀ ε > 0, ∃ N, ∀ n ≥ N, s n < ε` (nonnegative, eventually below ε) is caught" unfolding L13Ref.MutNonneg L13.good₁ L13.good₂ :
  L13Ref.MutNonneg L13.good₁ ∧ L13Ref.MutNonneg L13.good₂
#expect_caught "mutant `∀ ε > 0, ∀ N, ∃ n ≥ N, |s n| < ε` (close again and again) is caught" unfolding L13Ref.MutFrequently L13.bad₁ L13.bad₂ :
  ¬ L13Ref.MutFrequently L13.bad₁ ∧ ¬ L13Ref.MutFrequently L13.bad₂
#expect_caught "mutant `∃ N, ∀ n ≥ N, |s n| < 1` (eventually small) is caught" unfolding L13Ref.MutEventuallySmall L13.bad₁ L13.bad₂ :
  ¬ L13Ref.MutEventuallySmall L13.bad₁ ∧ ¬ L13Ref.MutEventuallySmall L13.bad₂
#expect_caught "mutant `∀ ε > 0, ∃ N, ∀ n ≥ N, s n < ε` (no absolute value) is caught" unfolding L13Ref.MutNoAbs L13.bad₁ L13.bad₂ :
  ¬ L13Ref.MutNoAbs L13.bad₁ ∧ ¬ L13Ref.MutNoAbs L13.bad₂
#expect_caught "mutant `decreasing, with a term within ε of 0` is caught" unfolding L13Ref.MutDecreasing L13.good₁ L13.good₂ :
  L13Ref.MutDecreasing L13.good₁ ∧ L13Ref.MutDecreasing L13.good₂

#level_report
