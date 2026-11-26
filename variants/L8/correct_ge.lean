def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x : ℝ, a ≥ f x
def FnLb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ y, f y ≥ a
def MonotoneFn (f : ℝ → ℝ) : Prop := ∀ ⦃a b⦄, a ≤ b → f a ≤ f b
