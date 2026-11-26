statement lt_iff' : ∀ a b : ℝ, a < b ↔ a ≤ b ∧ ¬ a = b
statement abs_lt' {x y : ℝ} : |x| < y ↔ x < y ∧ -y < x
statement le_abs' (x y : ℝ) : x ≤ |y| ↔ x ≤ -y ∨ x ≤ y
def HasZeroIn (f : ℝ → ℝ) (a b : ℝ) : Prop := ∃ x ∈ Set.Icc a b, f x = 0
