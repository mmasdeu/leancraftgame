/-
# Final audit: the AI proved Goldbach!

*The Annex is quiet when the Prover posts its announcement: "The AI proved Goldbach's
conjecture! And Collatz!" Lean accepts both proofs, with no `sorry`. Noor does not
celebrate. Noor opens the statements and hands them to you: everything since your first
day, from the quantifiers of the Logic world to the junk values of calculus, was practice
for this.*

```lean
theorem ai_goldbach :
    ∀ n, 2 < n → n % 2 = 0 → ∃ p q, Nat.Prime p ∧ Nat.Prime q → p + q = n :=
  fun _ _ _ => ⟨0, 0, fun h => absurd h.1 Nat.not_prime_zero⟩

theorem ai_collatz : ∀ n, ∃ k, collatz^[k] n ≤ n :=
  fun n => ⟨0, le_refl n⟩
```

The Prover did not lie: it proved exactly these statements. But a one-line proof of a
famous open problem is not a breakthrough. It is evidence that the statement is not the
problem.

* In `ai_goldbach`, `→` binds more loosely than `∧`: the body is
  `∃ p q, (Nat.Prime p ∧ Nat.Prime q) → p + q = n`. Take `p = q = 0`, which are not prime:
  the implication holds vacuously. It is the trap of level 11, `→` under `∃`.
* In `ai_collatz`, take `k = 0`: after zero steps you are at `n`, and `n ≤ n`.

## The auditor's tool: toy worlds

You cannot test a statement nobody can prove. You *can* test it in worlds where you know
the answer, as you did with the Prover's primes in level 23. So write the statement
**parametrised** by the notion it depends on:

* `GoldbachFor P`: "every even number greater than `2` is the sum of two numbers that
  satisfy `P`". With `P := Nat.Prime` it is Goldbach's conjecture; with `P := fun _ => False`
  (nothing is prime) it must be false; with `P := fun p => 2 ≤ p` it must be true.
* `CollatzFor o`: "from every **positive** start `n`, some step `k` has `o n k = 1`",
  where `o n k` is the number reached after `k` steps from `n`. With the Collatz map it
  is the Collatz conjecture. Why positive? The map sends `0` to `0 / 2 = 0`, so `0`
  never reaches `1`.

The referee checks your statements in several toy worlds, and also in the real one, where
it must *not* settle them: a statement of an open problem that a simple search settles is
vacuous, or false for a silly reason.

## Your task

1. `GoldbachFor` and `CollatzFor`, as described.
2. Audit three more theorems the Prover proved, about primes, convergence and
   derivatives (the questions below the lesson). For each, say whether the Lean
   statement says what the English claim says.
-/
import Mathlib.Tactic

namespace L51

def collatz (n : ℕ) : ℕ := if n % 2 = 0 then n / 2 else 3 * n + 1

def GoldbachFor (P : ℕ → Prop) : Prop :=
  sorry

def CollatzFor (o : ℕ → ℕ → ℕ) : Prop :=
  sorry

def q1 : Bool := sorry
def q2 : Bool := sorry
def q3 : Bool := sorry

end L51
