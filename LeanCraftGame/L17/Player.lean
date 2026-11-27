/-
# Injective, surjective, inverses

*Schröder–Bernstein starts from two injections, so the Annex needs injectivity stated
correctly. Sam's first draft read "if `a₁ = a₂` then `f a₁ = f a₂`". It compiles, and every
function satisfies it.*

Mathlib's injectivity is `Function.Injective`:

```lean
def Function.Injective (f : α → β) : Prop := ∀ ⦃a₁ a₂⦄, f a₁ = f a₂ → a₁ = a₂
```

If two inputs have the same output, they are the same input. The **order** matters: the
hypothesis is about outputs, the conclusion about inputs. Sam's converse,
`a₁ = a₂ → f a₁ = f a₂`, holds for every function and says nothing. (The brackets `⦃ ⦄`
make `a₁ a₂` implicit, as in the `Monotone` of level 8.)

`Function.Surjective f` says every `b : β` is an output: `∀ b, ∃ a, f a = b`. The order of
quantifiers matters here too (level 10). `∃ a, ∀ b, f a = b` would say one input hits
everything at once.

## Variants in Mathlib

* `Set.InjOn f s`: `f` is injective *on the set* `s`: `∀ x ∈ s, ∀ y ∈ s, f x = f y → x = y`.
  Squaring on ℝ isn't injective, but it is injective on `{x | 0 ≤ x}`.
* `Function.LeftInverse g f`: `∀ x, g (f x) = x`. "`g` undoes `f`."
* `Function.invFun f`: *an* inverse, built by choice. Its type, as `#check` prints it:

```lean
Function.invFun {α : Sort u} {β : Sort v} [Nonempty α] (f : α → β) : β → α
```

  For `y` in the range of `f`, it returns some `x` with `f x = y`. For `y` outside the
  range it must still return *something* of type `α`, so `α` needs an element. That's the
  instance argument `[Nonempty α]`. It's a left inverse of `f` when `f` is injective.

## Truncated subtraction, again

On ℕ, `n - 1` is `0` when `n = 0` (level 3). So `fun n => n - 1` sends both `0` and `1`
to `0`.

## Your task

1. Write your own `Inj` and `Surj` for functions `ℕ → ℕ`, without Mathlib's names. The
   referee tests them on functions such as `n + 1`, `n - 1`, `2 n`.
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
