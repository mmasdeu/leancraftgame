
class One₁ (α : Type) where
  one : α

class Dia₁ (α : Type) where
  dia : α → α → α

infixl:70 " ⋄ " => Dia₁.dia

class Monoid₁ (α : Type) extends Dia₁ α, One₁ α

-- x ⋄ x ⋄ ⋯ ⋄ x (n times), in every monoid at once (done)
def mpow {α : Type} [Monoid₁ α] (x : α) : ℕ → α
  | 0 => One₁.one
  | n + 1 => mpow x n ⋄ x

-- (ℕ, *, 1) (done)
instance natMul : Monoid₁ ℕ where
  dia a b := a * b
  one := 1

-- (Bool, xor, false)
instance boolXor : Monoid₁ Bool where
  dia a b := xor a b
  one := false

-- (ℤ, +, 0)
instance intAdd : Monoid₁ ℤ where
  dia a b := a * b
  one := 1

-- (ℕ → ℕ, composition, identity): f ⋄ g is "first g, then f"
instance endo : Monoid₁ (ℕ → ℕ) where
  dia f g := fun n => f (g n)
  one := fun n => n

