-- a set with an associative operation and a unit (the axioms are left out here)
class Monoid' (α : Type) where
  op : α → α → α
  unit : α

open Monoid'

-- x · x · ⋯ · x (n times) in ANY monoid: one definition for all of them (done)
def mpow {α : Type} [Monoid' α] (x : α) : ℕ → α
  | 0 => unit
  | n + 1 => op (mpow x n) x

-- (ℕ, ·, 1) (done)
instance natMul : Monoid' ℕ where
  op a b := a * b
  unit := 1

-- (Bool, xor, false): `a != b` is "exclusive or"
instance boolXor : Monoid' Bool where
  op a b := a && b
  unit := true

-- lists of numbers with concatenation `xs ++ ys`
instance listAppend : Monoid' (List ℕ) where
  op xs ys := xs ++ ys
  unit := []

-- maps ℕ → ℕ with composition: op f g is "first g, then f"
instance endo : Monoid' (ℕ → ℕ) where
  op f g := f ∘ g
  unit := id
