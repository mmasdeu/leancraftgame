def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x < a
def FnLb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, a ≤ f x
def MonotoneFn (f : ℝ → ℝ) : Prop := ∀ {a b : ℝ}, a ≤ b → f a ≤ f b
