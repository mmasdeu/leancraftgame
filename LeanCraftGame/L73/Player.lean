/-
# The AI proved the infinitude of primes!

The last world is the one the game was built for. Proofs are cheap now:
an automatic prover, human or not, can produce a Lean proof of almost any
true statement you hand it. What it cannot guarantee is that the statement
says what you meant. Lean checks the proof; **nobody checks the statement
but you**.

An AI announces a Lean proof that there are infinitely many primes. Lean
accepts it. Read the statement, not the proof:

* its `IsPrime` forgets something you met in the Logic world (what about
  `1`?);
* its "infinitely many" is `∀ n, ∃ p, P p ∧ p ≠ n`: "for every `n` there is
  a prime *different from* `n`". Two primes are enough for that.

The method of the auditor is the method of this whole game: build a **toy
world** (a predicate `P`) in which the claimed statement holds and the
intended one fails. If such a world exists, the statement does not
capture the theorem, whatever the proof.

The real statement, "for every `n` there is a prime `p ≥ n`", is Euclid's
theorem, and the "unbounded" pattern is the one from the Quantifier world.

Your task is in the comments of the file below.
-/
import Mathlib.Tactic

namespace L73

def IsPrime (p : Nat) : Prop := ∀ d, d ∣ p → d = 1 ∨ d = p

def AIClaim (P : Nat → Prop) : Prop := ∀ n, ∃ p, P p ∧ p ≠ n

theorem ai_primes : AIClaim IsPrime := by
  intro n
  by_cases h : n = 2
  · refine ⟨3, ?_, by omega⟩
    intro d hd
    have := Nat.le_of_dvd (by norm_num) hd
    interval_cases d <;> simp_all
  · refine ⟨2, ?_, fun h' => h h'.symm⟩
    intro d hd
    have := Nat.le_of_dvd (by norm_num) hd
    interval_cases d <;> simp_all

/-
Your task has three parts. Do not trust the AI's definitions either.

1. `Unbounded P`: the faithful statement "there are infinitely many
   numbers satisfying `P`", written so that it works for any `P`.
2. `smallWorld`: a made-up notion of "prime" in which the AI's claim is
   true but there are *not* infinitely many "primes". Make it look like
   a notion of primes: it should only contain numbers `≥ 2`, and
   nothing above `100`.
3. `fakePrime`: a number that the AI's `IsPrime` accepts but that is not
   a prime. (Mathlib's real notion is `Nat.Prime`.)

The referee checks your world against the AI's statement *and* against
its own copy of the real one.
-/

def Unbounded (P : Nat → Prop) : Prop :=
  sorry

def smallWorld : Nat → Prop :=
  sorry

def fakePrime : Nat :=
  sorry

end L73
