/-
# Set notation

*A new project: Noor wants the library to state the Schröder–Bernstein theorem, which is
about sets and images. First, some sets: the evens, the primes, the multiples.*

In Mathlib, a set of elements of `α` has type `Set α`. It's just a property: `x ∈ s` is a
proposition. `FnUb f a` from level 8 is such a property, and `{a | FnUb f a}` is the set
of upper bounds of `f`.

## Building sets

```lean
def evens' : Set ℕ := {n | Even n}          -- "the n such that n is even"
example : 4 ∈ evens' := …                   -- membership is a Prop
```

* `{x | P x}`: the set of `x` with property `P`.
* `x ∈ s` (`\in`), `x ∉ s` (`\notin`): membership.
* `s ⊆ t` (`\sub`): `∀ x, x ∈ s → x ∈ t`.
* `s ∩ t` (`\cap`), `s ∪ t` (`\cup`), `s \ t` (difference), `sᶜ` (`\compl`, the
  complement).
* `∅` (`\empty`) and `Set.univ`: the empty set and the set of everything.
* Intervals: `Set.Icc a b` is `{x | a ≤ x ∧ x ≤ b}`, `Set.Ici a` is `{x | a ≤ x}`.

## Indexed unions and intersections

A **family** of sets is a function `A : ι → Set α`, one set `A i` for each index `i`.

```lean
⋃ i, A i      -- \bigcup: x is in it when x ∈ A i for SOME i
⋂ i, A i      -- \bigcap: x is in it when x ∈ A i for EVERY i
⋃₀ S          -- the union of all the sets in a set of sets S
```

So `⋃` is an `∃` and `⋂` is a `∀`. The index can range over a set:
`⋃ k ∈ ({2, 3} : Set ℕ), A k` is `A 2 ∪ A 3`. `⋃ i : ℕ, Set.Icc 0 i` is all of ℕ, since
`n ∈ [0, n]`. `⋂ i : ℕ, Set.Ici i` is empty, since no number is `≥ i` for every `i`.

## Precedence

`ᶜ` binds tightest, then `∩`, then `∪`, then `∈` and `⊆`. When in doubt, use brackets:
`s ∩ (t ∪ u)` is "the elements of `s` that are in `t` or in `u`".

## Your task

Answer the two questions, then fill in the sets with Mathlib's `Even` and `Nat.Prime`.
Where a comment asks, use set operations, not a new property. Careful: `2` is prime, and
in `k ∣ n` the order says who divides whom.
-/
namespace L15

-- the even natural numbers
def evens : Set ℕ := sorry

-- the prime numbers
def primes : Set ℕ := sorry

-- the primes that are not even: build it from `primes` and `evens` with set operations
def oddPrimes : Set ℕ := sorry

-- the multiples of k: the n such that k divides n (`∣` is typed `\|`, it is not `|`)
def multiples (k : ℕ) : Set ℕ := sorry

-- the numbers that are a multiple of 4 or of 6, written as a union over k ∈ {4, 6}
-- of `multiples k` (an indexed union `⋃ k ∈ s, A k`)
def fourOrSix : Set ℕ := sorry

def q1 : Fin 3 := sorry
def q2 : Bool := sorry

end L15
