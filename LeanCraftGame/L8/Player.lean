/-
# ∀ and →

MIL's chapter 3 is about logic, and it starts with **upper bounds of functions**:

```lean
def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop :=
  ∀ x, f x ≤ a
```

`FnUb f a` is a `Prop`, a statement: "`a` is an upper bound of `f`", that is, "for every
`x`, `f x ≤ a`". The type `ℝ → ℝ` of `f` is a function type, and the same arrow `→`
between two statements means **implies**: `P → Q` is "if `P` then `Q`".

## ∀ with a hypothesis

"For every `x ≥ 0`, …" has a hypothesis inside the quantifier. Lean writes it
`∀ x, 0 ≤ x → …`, or with the shorthand `∀ x ≥ 0, …`. Mathlib's definition of a
monotone function:

```lean
def Monotone (f : ℝ → ℝ) : Prop := ∀ ⦃a b⦄, a ≤ b → f a ≤ f b
```

reads "for all `a` and `b`, if `a ≤ b` then `f a ≤ f b`". Without the hypothesis,
`∀ a b, f a ≤ f b` would say that every value is below every other, so `f` would be
constant.

## Implicit variables in a definition

The brackets `⦃a b⦄` (or `{a b}`) make `a` and `b` **implicit**: if `h : Monotone f` and
`hab : 1 ≤ 2`, then `h hab : f 1 ≤ f 2`. Lean reads `a` and `b` off `hab`. With `(a b)`
or `∀ a b`, you would have to write `h 1 2 hab`. Logically both say the same; for a user
the implicit version is lighter, which is why MIL and Mathlib use it.

## Your task

Write the three definitions.

* `FnUb f a`: `a` is an upper bound of `f`.
* `FnLb f a`: `a` is a lower bound of `f`.
* `MonotoneFn f`: `f` is monotone, with `a` and `b` **implicit**: `∀ {a b : ℝ}, …`.
-/
namespace L8

def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

def FnLb (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

def MonotoneFn (f : ℝ → ℝ) : Prop := sorry

end L8
