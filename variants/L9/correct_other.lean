def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x ≤ a
def FnHasUb (f : ℝ → ℝ) : Prop := ∃ a : ℝ, ∀ x, f x ≤ a
def FnHasLb (f : ℝ → ℝ) : Prop := ∃ b, ∀ y, f y ≥ b
def bound : ℝ := 100
def root : ℝ := 4 / 2
def TakesBothSigns (f : ℝ → ℝ) : Prop := ∃ x y, 0 < f x ∧ f y < 0
