/-
# ∀ and →

*A new project: bounds, monotone functions and, at the end, convergent sequences. Noor
starts with bounds of a function. Your definitions here come back later.*

```lean
def FnPos (f : ℝ → ℝ) : Prop :=
  ∀ x, 0 < f x
```

`FnPos f` says "for every `x`, `f x` is positive". A `def` whose type is `Prop` defines a
statement, which can be true or false.

The `→` in `ℝ → ℝ` builds a function type. Between two statements it means **implies**:
`P → Q` is "if `P` then `Q`".

## ∀ with a hypothesis

"For every `x ≥ 0`, …" puts a hypothesis inside the quantifier. Lean writes it
`∀ x, 0 ≤ x → …`, or `∀ x ≥ 0, …` for short:

```lean
def PosOnPos (f : ℝ → ℝ) : Prop := ∀ x, 0 < x → 0 < f x
```

Forget the hypothesis and the meaning changes: `∀ x, 0 < f x` is `FnPos f`, a much
stronger claim.

## Implicit variables in a definition

Curly brackets make a variable implicit: `∀ {x : ℝ}, 0 < x → 0 < f x`. If `h` is a proof
of that and `hx : 0 < 2`, then `h hx : 0 < f 2`: Lean reads `x` off `hx`. With `∀ x`,
you'd write `h 2 hx`. Mathlib's own definitions often use the brackets `⦃x⦄` instead,
which also make `x` implicit.

## Your task

Write the three definitions.

* `FnUb f a`: `a` is an upper bound of `f`.
* `FnLb f a`: `a` is a lower bound of `f`.
* `MonotoneFn f`: `f` is non-decreasing (Mathlib's `Monotone`), with the two points
  implicit: `∀ {a b : ℝ}, …`.
-/
namespace L8

def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

def FnLb (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

def MonotoneFn (f : ℝ → ℝ) : Prop := sorry

end L8
