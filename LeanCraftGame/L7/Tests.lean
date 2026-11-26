/- Hidden test battery for Level 7: Spot the bug: statements. -/
import LeanCraftGame.Referee
import LeanCraftGame.L7.Player

open L7

#no_sorry a₁
#no_sorry b₁
#no_sorry a₂
#no_sorry b₂
#no_sorry x₃
#no_sorry y₃
#no_sorry sq_le_sq_of_le
#no_sorry div_mul_cancel_ok
#level_start "Spot the bug: statements"

#expect_false "In ℕ, (0 - 1)² = 0² - 2·0·1 + 1²" :
  ((0 : ℕ) - 1) ^ 2 = 0 ^ 2 - 2 * 0 * 1 + 1 ^ 2
#expect_true "Part A: a₁, b₁ break (a - b)² = a² - 2ab + b² in ℕ" unfolding a₁ b₁ :
  (a₁ - b₁) ^ 2 ≠ a₁ ^ 2 - 2 * a₁ * b₁ + b₁ ^ 2
#expect_true "Part A: a₂ ≤ b₂ (the hypothesis holds)" unfolding a₂ b₂ : a₂ ≤ b₂
#expect_true "Part A: a₂² > b₂² (the conclusion fails)" unfolding a₂ b₂ : b₂ ^ 2 < a₂ ^ 2
#expect_true "Part A: x₃ / y₃ * y₃ ≠ x₃" unfolding x₃ y₃ : x₃ / y₃ * y₃ ≠ x₃
#expect_equiv "Part B: sq_le_sq_of_le, repaired" :
  L7.sq_le_sq_of_le ↔ ∀ a b : ℝ, 0 ≤ a → a ≤ b → a ^ 2 ≤ b ^ 2
  using fun a b ha hab => pow_le_pow_left₀ ha hab 2
#expect_equiv "Part B: div_mul_cancel_ok, repaired" :
  L7.div_mul_cancel_ok ↔ ∀ x y : ℝ, y ≠ 0 → x / y * y = x
  using fun x y h => div_mul_cancel₀ x h

#level_report
