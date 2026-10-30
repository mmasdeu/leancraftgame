structure Metric' (α : Type) where
  dist : α → α → ℤ
  eq_zero : ∀ a b, dist a b = 0 ↔ a = b
  nonneg : ∀ a b, 0 ≤ dist a a
  symm : ∀ a b, dist a b = dist b a
  triangle : ∀ a b c, dist a c ≤ dist a b + dist b c
