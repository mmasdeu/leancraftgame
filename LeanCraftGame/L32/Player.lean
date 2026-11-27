/-
# Classes and instances

*A new project. Noor has noticed that the library defines powers four times: in `ℕ`, in
`ℤ`, for the `GaussInt` of level 30, for permutations. "It is the same definition every
time. Write it once, and let Lean find the structure." The tool for that is the
**type class**, and this world builds a small copy of Mathlib's hierarchy of them.*

## Classes

A class is a structure whose instances Lean will *search for* by itself:

```lean
class One₁ (α : Type) where
  one : α

class Dia₁ (α : Type) where
  dia : α → α → α

infixl:70 " ⋄ " => Dia₁.dia

class Monoid₁ (α : Type) extends Dia₁ α, One₁ α
```

`One₁ α` says "`α` has a distinguished element", `Dia₁ α` "`α` has a binary operation",
written `a ⋄ b` (type `\diamond`). `extends` builds a bigger class from smaller ones: a
`Monoid₁ α` has both. (A real monoid class also has the axioms; they are left out
here, and the tests check them on your examples.)

## Instances

An **instance** says that a particular type has the structure:

```lean
instance natMul : Monoid₁ ℕ where
  dia a b := a * b
  one := 1
```

The Gaussian integers of level 30 are a monoid too, under their own product:

```lean
structure GaussInt where
  re : ℤ
  im : ℤ

instance gaussMul : Monoid₁ GaussInt where
  dia z w := ⟨z.re * w.re - z.im * w.im, z.re * w.im + z.im * w.re⟩
  one := ⟨1, 0⟩
```

## Using a class

A definition can ask for "any type with a monoid structure" with an *instance argument*
in square brackets, `[Monoid₁ α]`. Lean then finds the instance each time the definition
is used:

```lean
def mpow {α : Type} [Monoid₁ α] (x : α) : ℕ → α
  | 0 => One₁.one
  | n + 1 => mpow x n ⋄ x
```

`mpow 2 10` finds `natMul` and gives `1024`; `mpow (⟨0, 1⟩ : GaussInt) 2` finds
`gaussMul` and gives `⟨-1, 0⟩`, that is `i² = -1`, with no new definition of powers.
This search is how Mathlib knows that `ℝ` is a field and `ℤ` a ring, and why one lemma
about monoids applies to all of them. A type gets **one** instance of a class, so `ℕ`
cannot be a `Monoid₁` both under `*` and under `+`; Mathlib has separate additive classes
(`AddMonoid`) for that reason.

## Your task

Write three instances. Powers then come for free:

* `(Bool, xor, false)`: `xor a b` is "exactly one of `a`, `b`". Then `mpow true n` is the
  parity of `n`.
* `(ℤ, +, 0)`: here `x ⋄ y` means `x + y`, so `mpow x n` is `n * x`.
* `(ℕ → ℕ, ∘, id)`: `f ⋄ g` is the composition "first `g`, then `f`", as in `f ∘ g`.
  Then `mpow f n` is `f` applied `n` times.
-/
namespace L32

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

end L32
