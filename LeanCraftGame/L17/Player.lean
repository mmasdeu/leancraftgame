/-
# Injective, surjective, inverses

*Schröder–Bernstein starts from two injections. Sam's first draft of injectivity read "if
`a₁ = a₂` then `f a₁ = f a₂`". It compiles, and every function satisfies it.*

Mathlib's version:

```lean
def Function.Injective (f : α → β) : Prop := ∀ ⦃a₁ a₂⦄, f a₁ = f a₂ → a₁ = a₂
```

Same output means same input. The hypothesis is about outputs, the conclusion about
inputs. Sam's converse holds for every function. (`⦃ ⦄` makes `a₁ a₂` implicit, as in the
`Monotone` of level 8.)

`Function.Surjective f` says every `b : β` is an output: `∀ b, ∃ a, f a = b`. Quantifier
order matters again (level 10): `∃ a, ∀ b, f a = b` says one input hits everything.

## Variants

* `Set.InjOn f s`: `f` is injective *on* `s`: `∀ x ∈ s, ∀ y ∈ s, f x = f y → x = y`.
  Squaring on ℝ isn't injective, but it is on `{x | 0 ≤ x}`.
* `Function.LeftInverse g f`: `∀ x, g (f x) = x`, so `g` undoes `f`.
* `Function.invFun f`: *an* inverse, built by choice:

```lean
Function.invFun {α : Sort u} {β : Sort v} [Nonempty α] (f : α → β) : β → α
```

  For `y` in the range of `f`, it returns some `x` with `f x = y`. Outside the range it
  must still return something in `α`, hence `[Nonempty α]`. It's a left inverse of `f`
  when `f` is injective.

On ℕ, `n - 1` is `0` when `n = 0` (level 3), so `fun n => n - 1` sends both `0` and `1`
to `0`.

## Your task

1. Write your own `Inj` and `Surj` for `ℕ → ℕ`, without Mathlib's names. The referee
   tries them on `n + 1`, `n - 1`, `2 n` and others.
2. `pred'`: a left inverse of `fun n => n + 1`.
3. Answer the questions.
-/
namespace L17

def Inj (f : ℕ → ℕ) : Prop := sorry

def Surj (f : ℕ → ℕ) : Prop := sorry

-- a left inverse of `fun n => n + 1`
def pred' : ℕ → ℕ := sorry

def q1 : Fin 3 := sorry
def q2 : Bool := sorry
def q3 : Fin 3 := sorry

end L17
