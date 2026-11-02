def Injective (f : ℕ → ℕ) : Prop :=
  ∀ a b, a = b → f a = f b

def Surjective (f : ℕ → ℕ) : Prop :=
  ∀ y, ∃ x, f x = y

def Bijective (f : ℕ → ℕ) : Prop :=
  Injective f ∧ Surjective f
