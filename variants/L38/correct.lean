structure Metric' (α : Type) where
  dist : α → α → ℤ
  eq_zero : ∀ a b, dist a b = 0 ↔ a = b
  nonneg : ∀ a b, 0 ≤ dist a b
  symm : ∀ a b, dist a b = dist b a
  triangle : ∀ a b c, dist a c ≤ dist a b + dist b c

def UnifCont (f : ℝ → ℝ) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x y, dist x y < δ → dist (f x) (f y) < ε
