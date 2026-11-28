/-
# Final audit: the AI proved Goldbach!

*The Prover posts: "The AI proved Goldbach's conjecture! And Collatz!" Lean accepts both
proofs, with no `sorry`. Noor opens the statements and hands them to you.*

```lean
theorem ai_goldbach :
    ∀ n, 2 < n → n % 2 = 0 → ∃ p q, Nat.Prime p ∧ Nat.Prime q → p + q = n :=
  fun _ _ _ => ⟨0, 0, fun h => absurd h.1 Nat.not_prime_zero⟩

theorem ai_collatz : ∀ n, ∃ k, collatz^[k] n ≤ n :=
  fun n => ⟨0, le_refl n⟩
```

`collatz^[k] n` is `collatz` applied `k` times to `n`. The Prover proved exactly these
statements. A one-line proof of a famous open problem
means the statement is wrong.

* In `ai_goldbach`, `→` binds more loosely than `∧`, so the body is
  `∃ p q, (Nat.Prime p ∧ Nat.Prime q) → p + q = n`. Take `p = q = 0`, which aren't prime,
  and the implication holds vacuously. It's the trap of level 11, `→` under `∃`.
* In `ai_collatz`, take `k = 0`. After zero steps you're at `n`, and `n ≤ n`.

## Toy worlds

As in level 23, test a statement nobody can prove in worlds where you know the answer.
So write it **parametrised** by the notion it depends on:

* `GoldbachFor P`: "every even number greater than `2` is the sum of two numbers that
  satisfy `P`". With `P := Nat.Prime` it's Goldbach's conjecture. With
  `P := fun p => 2 ≤ p` it must be true.
* `CollatzFor o`: "from every **positive** start `n`, some step `k` has `o n k = 1`",
  where `o n k` is the number reached after `k` steps from `n`. With the Collatz map it's
  the Collatz conjecture. Positive, because the map sends `0` to `0 / 2 = 0`, so `0`
  never reaches `1`.

The referee checks your statements in several toy worlds (world A, B, C for Goldbach,
process A, B, C for Collatz), and in the real one, where it must *not* settle them. If a simple search settles your version of an open problem, it's
vacuous or false for a silly reason.

## Your task

1. `GoldbachFor` and `CollatzFor`, as described.
2. Audit three more theorems the Prover proved, about primes, convergence and
   derivatives (the questions below the lesson). For each, say whether the Lean
   statement says what the English claim says.
-/
import Mathlib.Tactic

namespace L44

def collatz (n : ℕ) : ℕ := if n % 2 = 0 then n / 2 else 3 * n + 1

def GoldbachFor (P : ℕ → Prop) : Prop :=
  sorry

def CollatzFor (o : ℕ → ℕ → ℕ) : Prop :=
  sorry

def q1 : Bool := sorry
def q2 : Bool := sorry
def q3 : Bool := sorry

end L44
