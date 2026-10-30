structure PartialOrder' (α : Type) where
  le : α → α → Prop
  refl : ∀ a b, le a b → le a a
  antisymm : ∀ a b, le a b → le b a → a = b
  trans : ∀ a b c, le a b → le b c → le a c
