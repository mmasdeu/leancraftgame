structure PartialOrder' (α : Type) where
  le : α → α → Prop
  refl : ∀ a, le a a
  antisymm : ∀ a b, a = b → le a b
  trans : ∀ a b c, le a b → le b c → le a c
