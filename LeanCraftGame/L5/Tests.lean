/- Hidden test battery for Level 5: Stating theorems. -/
import LeanCraftGame.Referee
import LeanCraftGame.L5.Player

#no_sorry L5.sq_add
#no_sorry L5.two_mul_le
#no_sorry L5.abs_mul_le
#no_sorry L5.min_comm'
#no_sorry L5.max_assoc'
#level_start "Stating theorems"

#expect_false "(a + b)² = a² + b² for all reals" :
  ∀ a b : ℝ, (a + b) ^ 2 = a ^ 2 + b ^ 2
#expect_equiv "sq_add says (a + b)² = a² + 2ab + b²" :
  L5.sq_add ↔ ∀ a b : ℝ, (a + b) ^ 2 = a ^ 2 + 2 * a * b + b ^ 2
  using add_sq
#expect_equiv "two_mul_le says 2ab ≤ a² + b²" :
  L5.two_mul_le ↔ ∀ a b : ℝ, 2 * a * b ≤ a ^ 2 + b ^ 2
  using two_mul_le_add_sq
#expect_equiv "abs_mul_le says |ab| ≤ (a² + b²) / 2" :
  L5.abs_mul_le ↔ ∀ a b : ℝ, |a * b| ≤ (a ^ 2 + b ^ 2) / 2
  using fun a b => by
    rw [abs_mul, le_div_iff₀ (by norm_num : (0:ℝ) < 2)]
    nlinarith [sq_nonneg (|a| - |b|), sq_abs a, sq_abs b]
#expect_equiv "min_comm' says min a b = min b a" :
  L5.min_comm' ↔ ∀ a b : ℝ, min a b = min b a
  using min_comm
#expect_equiv "max_assoc' says max a (max b c) = max (max a b) c" :
  L5.max_assoc' ↔ ∀ a b c : ℝ, max a (max b c) = max (max a b) c
  using fun a b c => (max_assoc a b c).symm

#level_report
