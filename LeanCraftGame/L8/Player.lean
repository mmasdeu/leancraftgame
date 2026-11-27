/-
# ∀ and →

*A new project: bounds, monotone functions and, at the end, convergent sequences. Noor
starts with an upper bound of a function. Your definitions here come back later.*

```lean
def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop :=
  ∀ x, f x ≤ a
```

`FnUb f a` is a `Prop`, a statement: "for every `x`, `f x ≤ a`". The `→` in `ℝ → ℝ`
builds a function type. Between two statements it means **implies**: `P → Q` is "if `P`
then `Q`".

## ∀ with a hypothesis

"For every `x ≥ 0`, …" puts a hypothesis inside the quantifier. Lean writes it
`∀ x, 0 ≤ x → …`, or `∀ x ≥ 0, …` for short. Here is Mathlib's monotone function:

```lean
def Monotone (f : ℝ → ℝ) : Prop := ∀ ⦃a b⦄, a ≤ b → f a ≤ f b
```

It reads "for all `a` and `b`, if `a ≤ b` then `f a ≤ f b`". Without the hypothesis,
`∀ a b, f a ≤ f b` says every value is below every other, so `f` is constant.

## Implicit variables in a definition

The brackets `⦃a b⦄` (or `{a b}`) make `a` and `b` implicit. If `h : Monotone f` and
`hab : 1 ≤ 2`, then `h hab : f 1 ≤ f 2`: Lean reads `a` and `b` off `hab`. With `(a b)`
or `∀ a b`, you'd write `h 1 2 hab`. Same meaning, but Mathlib prefers the lighter one.

## Your task

Write the three definitions.

* `FnUb f a`: `a` is an upper bound of `f`.
* `FnLb f a`: `a` is a lower bound of `f`.
* `MonotoneFn f`: `f` is monotone, with `a` and `b` implicit: `∀ {a b : ℝ}, …`.
-/
namespace L8

def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

def FnLb (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

def MonotoneFn (f : ℝ → ℝ) : Prop := sorry

end L8
