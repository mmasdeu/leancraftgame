structure Metric' (α : Type) where
  dist : α → α → ℤ
  self : ∀ a, dist a a = 0
  sep : ∀ a b, a ≠ b → 0 < dist a b
  symm : ∀ a b, dist a b = dist b a
  triangle : ∀ a b c, dist a c ≤ dist a b + dist b c

def UnifCont (f : ℝ → ℝ) : Prop :=
  ∀ ε, ε > 0 → ∃ δ, δ > 0 ∧ ∀ x y : ℝ, dist x y < δ → dist (f x) (f y) < ε
