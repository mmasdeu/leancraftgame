def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x ≤ a
def FnHasUb (f : ℝ → ℝ) : Prop := ∃ a, FnUb f a
def NotFnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∃ x, a < f x
def NoUpperBound (f : ℝ → ℝ) : Prop := ∀ a, ∃ x, a < f x
def NotMonotone (f : ℝ → ℝ) : Prop := ∃ x y, x ≤ y ∧ f y < f x
def BoundedSeq (u : ℕ → ℕ) : Prop := ∃ M, ∀ n, u n < M
