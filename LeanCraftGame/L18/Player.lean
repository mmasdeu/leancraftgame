/-
# Injective, surjective, inverses

*Schröder–Bernstein starts from two injections. Sam's first draft of injectivity compiles,
and every function satisfies it:*

```lean
def SamInj (f : α → β) : Prop := ∀ a₁ a₂, a₁ = a₂ → f a₁ = f a₂
```

Mathlib's version goes the other way:

```lean
def Function.Injective (f : α → β) : Prop := ∀ ⦃a₁ a₂⦄, f a₁ = f a₂ → a₁ = a₂
```

Same output means same input. The hypothesis is about outputs, the conclusion about
inputs. (`⦃ ⦄` makes `a₁ a₂` implicit, as in the `Monotone` of level 8; `∀ a₁ a₂, …`
works just as well for your own definitions.)

`Function.Surjective f` says every `b : β` is an output: `∀ b, ∃ a, f a = b`. Quantifier
order matters again (level 10): `∃ a, ∀ b, f a = b` says one input hits everything.

## Variants

* `Set.InjOn f s`: `∀ x ∈ s, ∀ y ∈ s, f x = f y → x = y`. Here `∀ x ∈ s, …` is short
  for `∀ x, x ∈ s → …`. Squaring on ℝ isn't injective, but it is on `{x | 0 ≤ x}`.
* `Function.LeftInverse g f`: `∀ x, g (f x) = x`, so `g` undoes `f`.
* `Function.invFun f`: *an* inverse:

```lean
Function.invFun [Nonempty α] (f : α → β) : β → α
```

  For `y` in the range of `f`, it returns some `x` with `f x = y`. If there are several,
  Lean picks one (by the axiom of choice) without saying which. `[Nonempty α]` is an
  assumption in square brackets: `α` has at least one element. Lean finds such
  assumptions by itself.

Remember that on ℕ, subtraction stops at zero (level 3).

## Your task

1. Write your own `Inj` and `Surj` for `ℕ → ℕ`, without Mathlib's names. The referee
   tries them on `n + 1`, `n - 1`, `2 n` and others.
2. `pred'`: a left inverse of `fun n => n + 1`.
3. Answer the questions.
-/
namespace L18

def Inj (f : ℕ → ℕ) : Prop := sorry

def Surj (f : ℕ → ℕ) : Prop := sorry

-- a left inverse of `fun n => n + 1`
def pred' : ℕ → ℕ := sorry

def q1 : Fin 3 := sorry
def q2 : Bool := sorry
def q3 : Fin 3 := sorry

end L18
