-- f is a homomorphism of (ℕ, +, 0) to itself: f 0 = 0 and f (a + b) = f a + f b
def IsAddHom (f : ℕ → ℕ) : Prop := f 0 = 0 ∧ ∀ a b, f (a + b) = f a + f b

-- f is a homomorphism of (ℕ, +, 0) to (ℕ, ·, 1): f 0 = 1 and f (a + b) = f a · f b
def IsExpHom (f : ℕ → ℕ) : Prop := f 0 = 1 ∧ ∀ a b, f (a + b) = f a * f b

-- an additive homomorphism that is not surjective
def homNotOnto : ℕ → ℕ := fun _ => 0

-- a bijection of ℕ that is its own inverse and is not an additive homomorphism
def bijNotHom : ℕ → ℕ := fun n => if n = 2 then 3 else if n = 3 then 2 else n
