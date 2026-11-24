/-
# Classes and instances

`x ^ n` means repeated multiplication in `ℕ`, in `ℤ`, in a group of
matrices, in the monoid of words: the *same* definition, read in different
structures. Lean expresses this with **type classes**.

```lean
class Monoid' (α : Type) where
  op : α → α → α
  unit : α
```

declares the *kind* of structure; an **instance** says that a particular
type has one:

```lean
instance natMul : Monoid' ℕ where
  op a b := a * b
  unit := 1
```

A definition can then ask for "any type with a monoid structure" with a
square-bracket argument `[Monoid' α]`, and Lean **finds** the instance by
itself whenever the definition is used: `mpow 2 10` uses `natMul`,
`mpow true 3` uses the instance on `Bool`. This automatic search is how
Mathlib knows that `ℝ` is a field, `ℤ` a ring, and `ℕ → ℕ` a monoid under
composition, and why one theorem about monoids applies to all of them.

The same type can carry several structures (`ℕ` under `+` and under `·`);
a class allows only one canonical instance per type, which is why Mathlib
has `Additive` and `Multiplicative` wrappers.

## Your task

Write the three instances. Powers then come for free: in `(Bool, xor)`,
`mpow true n` computes the parity of `n`; in `(ℕ → ℕ, ∘)`, `mpow f n` is
the `n`-th iterate of `f`.
-/

namespace L53

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
  op a b := sorry
  unit := sorry

-- lists of numbers with concatenation `xs ++ ys`
instance listAppend : Monoid' (List ℕ) where
  op xs ys := sorry
  unit := sorry

-- maps ℕ → ℕ with composition: op f g is "first g, then f"
instance endo : Monoid' (ℕ → ℕ) where
  op f g := sorry
  unit := sorry

end L53
