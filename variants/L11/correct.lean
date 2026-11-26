statement lt_iff' (x y : ℝ) : x < y ↔ x ≤ y ∧ x ≠ y
statement abs_lt' (x y : ℝ) : |x| < y ↔ -y < x ∧ x < y
statement le_abs' (x y : ℝ) : x ≤ |y| ↔ x ≤ y ∨ x ≤ -y
def HasZeroIn (f : ℝ → ℝ) (a b : ℝ) : Prop := ∃ x, a ≤ x ∧ x ≤ b ∧ f x = 0
