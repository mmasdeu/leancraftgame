def Injective (f : ℕ → ℕ) : Prop :=
  ∀ a b, a ≠ b → f a ≠ f b

def Surjective (f : ℕ → ℕ) : Prop :=
  ∀ y, ∃ x, y = f x

def Bijective (f : ℕ → ℕ) : Prop :=
  (∀ a b, f a = f b → a = b) ∧ ∀ y, ∃ x, f x = y
