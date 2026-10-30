/-
# The AI proved the infinitude of primes!

An AI assistant was asked to formalise and prove Euclid's theorem:

  "There are infinitely many primes."

It came back with the statement and proof below. Both compile, there is
no `sorry`, and this time the theorem is even *true*. So what is the
problem?

## How to audit a formalisation

A proof only shows that the statement is true. Whether the statement
*says what the claim says* is a separate question, and no proof can
answer it. Before you trust a formalisation, go through this list:

1. **Say the formal statement out loud in plain words**, quantifier by
   quantifier, and compare with the claim. Do not read what the AI
   *meant*, read what it wrote.
2. **Look for the missing ingredient.** Which word of the claim has no
   counterpart in the formula? ("infinitely many" needs a size or a bound
   somewhere.)
3. **Look for the cheapest witness.** For a `∃`, what is the laziest thing
   that could satisfy it? For a `∀`, what is the smallest input?
4. **Check every definition on its borders**: `0`, `1`, `2`.
5. **Test in toy worlds.** Replace the notion ("prime") by a made-up one
   whose answer you know, finite, empty, everything, and see whether the
   statement still gives the right answer.

The AI's `AIClaim` below is stated for *any* notion of "prime" `P`, which
makes it easy to run step 5. `AIClaim IsPrime` is the AI's theorem.
-/
namespace L115

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
  ∃ p, ∀ n, n < p ∧ P p

def smallWorld : Nat → Prop :=
  fun p => p = 2 ∨ p = 3

def fakePrime : Nat :=
  1
