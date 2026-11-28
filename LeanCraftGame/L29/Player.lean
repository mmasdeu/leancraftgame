/-
# Classes and instances

*A new project. The library defines powers four times: in `ℕ`, in `ℤ`, for the `GaussInt`
of level 30, and for permutations. Noor wants it written once, with Lean finding the
structure. This world builds a small copy of Mathlib's **type classes**.*

## Classes

A class is a structure whose instances Lean searches for by itself:

```lean
class One₁ (α : Type) where
  one : α

class Dia₁ (α : Type) where
  dia : α → α → α

infixl:70 " ⋄ " => Dia₁.dia

class Monoid₁ (α : Type) extends Dia₁ α, One₁ α
```

`One₁ α` says `α` has a chosen element. `Dia₁ α` says `α` has a binary operation, written
`a ⋄ b` (type `\diamond`). `extends` combines classes, so a `Monoid₁ α` has both. A real
monoid class would also have the axioms. Here the tests check them on your examples.

## Instances

An **instance** says that a given type has the structure:

```lean
instance natMul : Monoid₁ ℕ where
  dia a b := a * b
  one := 1
```

## Using a class

A definition asks for any monoid through an instance argument in square brackets,
`[Monoid₁ α]`. Lean finds the instance at each use:

```lean
def mpow {α : Type} [Monoid₁ α] (x : α) : ℕ → α
  | 0 => One₁.one
  | n + 1 => mpow x n ⋄ x
```

`mpow 2 10` finds `natMul` and gives `1024`. This search is how Mathlib knows `ℝ` is a field,
and why one lemma about monoids covers them all. A type gets one instance of a class, so
`ℕ` can't be a `Monoid₁` under both `*` and `+`. That's why Mathlib has separate additive
classes such as `AddMonoid`.

## Your task

Write three instances. Powers then come for free:

* `(Bool, xor, false)`: the Lean function `xor a b` is `true` when exactly one of `a`, `b`
  is `true`.
* `(ℤ, +, 0)`: here `x ⋄ y` means `x + y`.
* `(ℕ → ℕ, ∘, id)`: `f ⋄ g` is "first `g`, then `f`". In Lean that is `f ∘ g`
  (type `\comp`), the function `fun n => f (g n)`. The identity function is `id`.
  Then `mpow f n` is `f` applied `n` times.

The tests write `(· * 2)` for the function `fun n => n * 2`.
-/
namespace L29

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
  dia a b := sorry
  one := sorry

-- (ℤ, +, 0)
instance intAdd : Monoid₁ ℤ where
  dia a b := sorry
  one := sorry

-- (ℕ → ℕ, composition, identity): f ⋄ g is "first g, then f"
instance endo : Monoid₁ (ℕ → ℕ) where
  dia f g := sorry
  one := sorry

end L29
