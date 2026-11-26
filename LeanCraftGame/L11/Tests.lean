/- Hidden test battery for Level 11: ∧, ∨ and ↔. -/
import LeanCraftGame.Referee
import LeanCraftGame.L11.Player

#no_sorry L11.lt_iff'
#no_sorry L11.abs_lt'
#no_sorry L11.le_abs'
#no_sorry L11.HasZeroIn
#level_start "∧, ∨ and ↔"

#expect_equiv "lt_iff' says x < y ↔ x ≤ y ∧ x ≠ y" :
  L11.lt_iff' ↔ ∀ x y : ℝ, x < y ↔ x ≤ y ∧ x ≠ y
  using fun x y => lt_iff_le_and_ne
#expect_equiv "abs_lt' says |x| < y ↔ -y < x ∧ x < y" :
  L11.abs_lt' ↔ ∀ x y : ℝ, |x| < y ↔ -y < x ∧ x < y
  using fun x y => abs_lt
#expect_equiv "le_abs' says x ≤ |y| ↔ x ≤ y ∨ x ≤ -y" :
  L11.le_abs' ↔ ∀ x y : ℝ, x ≤ |y| ↔ x ≤ y ∨ x ≤ -y
  using fun x y => le_abs
#expect_true "some x satisfies x > 5 → x = 0" :
  ∃ x : ℝ, x > 5 → x = 0
#expect_true "x ↦ x - 1 has a zero in [0, 2]" unfolding L11.HasZeroIn :
  L11.HasZeroIn (fun x => x - 1) 0 2
#expect_true "x ↦ x² - 4 has a zero in [0, 3]" unfolding L11.HasZeroIn :
  L11.HasZeroIn (fun x => x ^ 2 - 4) 0 3
#expect_false "x ↦ x + 10 has a zero in [0, 1]" unfolding L11.HasZeroIn :
  L11.HasZeroIn (fun x => x + 10) 0 1

#level_report
