structure PartialOrder' (α : Type) where
  le : α → α → Prop
  refl : ∀ a, le a a
  antisymm : ∀ a b, le a b → le b a → a = b
  trans : ∀ a b, le a b → le b a → le a a
