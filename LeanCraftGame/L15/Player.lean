/-
# Set notation

*A new project. Noor wants the Annex's library to state a famous construction, the
Schröder–Bernstein theorem, and it is written in the language of sets and images. First the
vocabulary: Noor asks for the even numbers, the primes and the multiples, as sets.*

In Mathlib, a set of elements of a type `α` has type `Set α`, and it is nothing more than a
property: `x ∈ s` is a proposition. You already know such properties: `FnUb f a` from
level 8 ("`a` is an upper bound of `f`") is one, and `{a | FnUb f a}` is the set of the upper
bounds of `f`.

## Building sets

```lean
def evens' : Set ℕ := {n | Even n}          -- "the n such that n is even"
example : 4 ∈ evens' := …                   -- membership is a Prop
```

* `{x | P x}`: the set of `x` with the property `P` (set-builder notation).
* `x ∈ s` (`\in`) and `x ∉ s` (`\notin`): membership.
* `s ⊆ t` (`\sub`): every element of `s` is in `t`, that is `∀ x, x ∈ s → x ∈ t`.
* `s ∩ t` (`\cap`), `s ∪ t` (`\cup`), `s \ t` (difference), `sᶜ` (`\compl`, the
  complement): intersection, union, the elements of `s` not in `t`, everything not in `s`.
* `∅` (`\empty`) and `Set.univ`: the empty set and the set of everything.
* Intervals: `Set.Icc a b` is `{x | a ≤ x ∧ x ≤ b}`, `Set.Ici a` is `{x | a ≤ x}`.

## Indexed unions and intersections

A **family** of sets is a function `A : ι → Set α`, one set `A i` for each index `i`.

```lean
⋃ i, A i      -- \bigcup: x is in it when x ∈ A i for SOME i
⋂ i, A i      -- \bigcap: x is in it when x ∈ A i for EVERY i
⋃₀ S          -- the union of all the sets in a set of sets S
```

`⋃` is an `∃` and `⋂` is a `∀`, the quantifiers of the Logic world in disguise. The index
can range over a set: `⋃ k ∈ ({2, 3} : Set ℕ), A k` is `A 2 ∪ A 3`. For example
`⋃ i : ℕ, Set.Icc 0 i` is all of ℕ: every `n` lies in `[0, n]`. And `⋂ i : ℕ, Set.Ici i`
is empty: no number is `≥ i` for every `i`.

## Reading set expressions

Operators have precedences, like `+` and `*`: `ᶜ` binds tightest, then `∩`, then `∪`,
then `∈` and `⊆`. Write brackets when in doubt: `s ∩ (t ∪ u)` reads "the elements of `s`
that are in `t` or in `u`".

## Your task

Answer the two questions under the lesson, then fill in the sets. Use Mathlib's `Even`
and `Nat.Prime`, and the operations above (not a new property) where the comment asks.
Two traps wait at the border: `2` is a prime, and in `k ∣ n` the order says who divides whom.
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
