/-
# Generic bounds and comparisons

**ACT I — SEQUENCES**

This is the same journey, in a new order: **sequences → limits → topology**. Your
current step is to **generalise bounds, intervals and maxima from a numerical example to the right ordered type.**

"Between", "upper bound" and "the larger of two numbers" make sense for ℕ, ℤ,
ℚ, ℝ and many other types. Mathlib states such definitions **once**, for every
suitable type:

```lean
def AlwaysBelow {α : Type*} [Preorder α] (u : ℕ → α) (B : α) : Prop :=
  ∀ n, u n ≤ B
```

* `{α : Type*}` says "for any type `α`". The curly braces make it **implicit**:
  nobody writes `α` when using `AlwaysBelow`, Lean works it out from `u` and
  `B`. (`α` is typed `\a`; `Type*` is Mathlib's way to say "some type".)
* `[Preorder α]` is an **instance argument**: it asks that `α` comes with a
  `≤` that behaves like an order. Lean finds it automatically for ℕ, ℤ, ℚ, ℝ.
  If you forget it, Lean says *failed to synthesize LE α*: it does not know what
  `≤` means on an arbitrary type.

## Choosing the class

* `[Preorder α]` gives `≤` and `<`.
* `[LinearOrder α]` also says that any two elements are comparable, so that
  `if a ≤ b then … else …` can be **computed**. With only `Preorder`, Lean
  reports *failed to synthesize Decidable (a ≤ b)*.

Ask for as little as you need: the weaker the class, the more types your
definition applies to.

## Your task

The three definitions at the bottom only work for `ℕ`. Make each of them work
for every type with an order. The tests use them on ℕ, ℤ and ℚ.

## The road from here

Use divisibility to structure the indices themselves.

-/
namespace L30

-- every term of u is at most B, for any type with ≤ (already done)
def AlwaysBelow {α : Type*} [Preorder α] (u : ℕ → α) (B : α) : Prop := ∀ n, u n ≤ B

-- Make the three definitions below work for every type with an order
-- (ℕ, ℤ, ℚ, ℝ, …), not just for ℕ.

-- a ≤ x ≤ b
def Between (a b x : ℕ) : Prop := a ≤ x ∧ x ≤ b

-- B is at least every element of s
def IsUpperBound (s : Set ℕ) (B : ℕ) : Prop := ∀ x ∈ s, x ≤ B

-- the larger of a and b
def largest (a b : ℕ) : ℕ := if a ≤ b then b else a

end L30
