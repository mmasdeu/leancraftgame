def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x ≤ a
def FnLb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, a ≤ f x
def FnHasUb (f : ℝ → ℝ) : Prop := ∀ a, FnUb f a
def FnHasLb (f : ℝ → ℝ) : Prop := ∃ a, ∀ x, a ≤ f x
def bound : ℝ := 3
def root : ℝ := 2
def TakesBothSigns (f : ℝ → ℝ) : Prop := (∃ x, f x > 0) ∧ (∃ x, f x < 0)
