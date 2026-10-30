def Injective (f : ℕ → ℕ) : Prop :=
  ∀ a b, f a = f b → a = b

def Surjective (f : ℕ → ℕ) : Prop :=
  ∀ x, ∃ y, f x = y

def Bijective (f : ℕ → ℕ) : Prop :=
  Injective f ∧ Surjective f
