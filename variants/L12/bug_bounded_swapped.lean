def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x ≤ a
def FnHasUb (f : ℝ → ℝ) : Prop := ∃ a, FnUb f a
def NotFnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∃ x, f x > a
def NoUpperBound (f : ℝ → ℝ) : Prop := ∀ a, ∃ x, f x > a
def NotMonotone (f : ℝ → ℝ) : Prop := ∃ a b, a ≤ b ∧ f a > f b
def BoundedSeq (u : ℕ → ℕ) : Prop := ∀ n, ∃ M, u n ≤ M
