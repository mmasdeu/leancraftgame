/-
# Generality

"Let `x ≤ y` in an ordered set." Mathematicians state definitions once, for
every structure that supports them, and Lean does the same with **type
variables** and **type classes**:

```lean
def AlwaysBelow {α : Type*} [Preorder α] (u : ℕ → α) (B : α) : Prop := ∀ n, u n ≤ B
```

* `{α : Type*}`: for every type `α` (implicit: Lean infers it from `u`);
* `[Preorder α]`: provided `α` carries a preorder, i.e. a reflexive and
  transitive `≤`. Lean finds the order of `ℕ`, `ℤ`, `ℚ`, `ℝ`, `Set X`, … by
  itself.

The same definition then applies to sequences of naturals, of reals, of
sets ordered by inclusion. Choose the **weakest** structure the definition
needs: `≤` needs `Preorder` (or `LE`); `max` needs a `LinearOrder`
(on a partial order such as sets, two elements need not be comparable).

The general version is not just more reusable; it is more honest about what
the definition depends on.

## Your task

Generalise `Between`, `IsUpperBound` and `largest` from `ℕ` to an arbitrary
ordered type. The referee tests them on `ℕ`, `ℤ`, `ℚ` and on sets.
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
