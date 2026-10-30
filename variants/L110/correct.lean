-- f stays between -M and M (already done)
def BoundedBy (f : ℝ → ℝ) (M : ℝ) : Prop := ∀ x, |f x| ≤ M

-- δ is a good choice for ε at a: δ > 0, and every x within δ of a
-- has f x within ε of f a
def IsDeltaFor (f : ℝ → ℝ) (a ε δ : ℝ) : Prop :=
  0 < δ ∧ ∀ x, |x - a| < δ → |f x - f a| < ε

-- f is continuous at a: for every ε > 0 some δ is a good choice
def ContAt (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ δ, IsDeltaFor f a ε δ
