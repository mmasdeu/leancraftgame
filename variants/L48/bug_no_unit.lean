-- f is a homomorphism of (ℕ, +, 0) to itself: f 0 = 0 and f (a + b) = f a + f b
def IsAddHom (f : ℕ → ℕ) : Prop := f 0 = 0 ∧ ∀ a b, f (a + b) = f a + f b

-- f is a homomorphism of (ℕ, +, 0) to (ℕ, ·, 1): f 0 = 1 and f (a + b) = f a · f b
def IsExpHom (f : ℕ → ℕ) : Prop := ∀ a b, f (a + b) = f a * f b

-- an additive homomorphism that is not surjective
def homNotOnto : ℕ → ℕ := fun n => 2 * n

-- a bijection of ℕ that is its own inverse and is not an additive homomorphism
def bijNotHom : ℕ → ℕ := fun n => if n = 0 then 1 else if n = 1 then 0 else n
