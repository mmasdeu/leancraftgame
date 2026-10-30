/-
# Sets

`Set ℕ` is the type of sets of natural numbers.

* `{n | n % 2 = 0}` is the set of the `n` such that `n % 2 = 0`
  ("set-builder notation"). The `|` is the plain keyboard bar.
* `x ∈ s` says that `x` belongs to `s` (type `\in`); `x ∉ s` is `\notin`.
* `s ⊆ t` says that every element of `s` is in `t` (type `\sub`).
* `∅` is the empty set (`\empty`).
* Bounded quantifiers work with `∈`: `∀ x ∈ s, P x` means
  `∀ x, x ∈ s → P x`, and `∃ x ∈ s, P x` means `∃ x, x ∈ s ∧ P x`.

In Mathlib a set *is* a predicate: `x ∈ {n | P n}` is just `P x`.

```lean
def evens : Set ℕ := {n | n % 2 = 0}
```

## Your task

`evens` is done. Define `multiplesOf k` and `BoundedSet s`.
-/
namespace L19

-- the even numbers (already done)
def evens : Set ℕ := {n | n % 2 = 0}

-- the multiples of k: 0, k, 2k, 3k, …     (12 ∈ multiplesOf 3, but not 13)
def multiplesOf (k : ℕ) : Set ℕ := sorry

-- some number B is at least as big as every element of s
def BoundedSet (s : Set ℕ) : Prop := sorry

end L19
