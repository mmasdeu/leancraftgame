/-
# Using Mathlib

Mathlib, Lean's mathematical library, already defines a large part of
undergraduate mathematics, and the right move is usually to use its
definitions rather than write your own: theorems are proved about *its*
`Even`, *its* `Nat.Prime`, *its* `Function.Injective`, and a home-made
variant, however correct, is cut off from them.

Mathlib's names follow conventions you can guess:

* predicates on numbers: `Even n`, `Odd n`, `Nat.Prime p` (or `p.Prime`);
* divisibility `a ∣ b`, divisors: `n.divisors`, `n.properDivisors` (the
  divisors smaller than `n`), as finite sets;
* properties of functions live in `Function`: `Function.Injective f`,
  `Function.Surjective f`, `Function.Bijective f`;
* big operators: `∑ d ∈ s, f d` is the sum of `f d` over the finite set `s`
  (type `\sum`).

The Greeks sorted numbers by comparing `n` with the sum of its proper
divisors: **perfect** when they are equal (`6 = 1 + 2 + 3`), **abundant**
when the sum is larger (`12 < 1 + 2 + 3 + 4 + 6 = 16`), deficient
otherwise (every prime). Euclid and Euler described the even perfect
numbers; whether an odd one exists is open. You will build perfect numbers
from scratch in the Finite world.

## Your task

Define `IsAbundant`, `CommonDivisor` and `OneToOne` with Mathlib's notions.
-/

namespace L29

-- n is even and at least 4 (already done, with Mathlib's `Even`)
def BigEven (n : ℕ) : Prop := Even n ∧ 4 ≤ n

-- n is abundant: the sum of its proper divisors exceeds n   (12 < 1 + 2 + 3 + 4 + 6)
def IsAbundant (n : ℕ) : Prop := sorry

-- d divides both a and b                               (CommonDivisor 3 6 9)
def CommonDivisor (d a b : ℕ) : Prop := sorry

-- f never takes the same value twice (use Mathlib's name for this)
def OneToOne (f : ℕ → ℕ) : Prop := sorry

end L29
