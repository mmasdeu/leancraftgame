-- f stays between -M and M (already done)
def BoundedBy (f : ℝ → ℝ) (M : ℝ) : Prop := ∀ x, |f x| ≤ M

def IsDeltaFor (f : ℝ → ℝ) (a ε δ : ℝ) : Prop :=
  0 < δ ∧ ∀ x, |x - a| < δ → |f x - a| < ε

def ContAt (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ δ, IsDeltaFor f a ε δ
