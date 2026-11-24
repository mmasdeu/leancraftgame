/-
# Sets

A **set** of natural numbers is written `Set ℕ`, and the set of the `n`
satisfying a property is `{n | P n}`:

```lean
def evens : Set ℕ := {n | n % 2 = 0}
```

Membership `x ∈ s` (type `\in`) is then *by definition* the property:
`4 ∈ evens` is the statement `4 % 2 = 0`. In Lean, as in most of modern
mathematics, a subset is nothing but a predicate; `Set ℕ` is `ℕ → Prop` in
disguise. Everything else is defined through membership:

* `s ⊆ t` is `∀ x, x ∈ s → x ∈ t`;
* `s ∩ t = {x | x ∈ s ∧ x ∈ t}`, `s ∪ t = {x | x ∈ s ∨ x ∈ t}`;
* `s = t` means the same members (extensionality).

A set of numbers is **bounded** when one number is at least all of its
elements. Note the order of the quantifiers once more: `∃ B, ∀ x ∈ s, x ≤
B`. The set of primes is not bounded (Euclid); every finite set is.

## Your task

Define `multiplesOf k` (the multiples of `k`: `0, k, 2k, …`) and
`BoundedSet s`. What is `multiplesOf 0`?
-/
namespace L28

-- the even numbers (already done)
def evens : Set ℕ := {n | n % 2 = 0}

-- the multiples of k: 0, k, 2k, 3k, …     (12 ∈ multiplesOf 3, but not 13)
def multiplesOf (k : ℕ) : Set ℕ := sorry

-- some number B is at least as big as every element of s
def BoundedSet (s : Set ℕ) : Prop := sorry

end L28
