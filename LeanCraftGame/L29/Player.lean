/-
# The AI proved Goldbach!

The last world asks the hardest question about formalisation: does the formal
statement **say what it claims to say**? Lean checks that a proof proves the
statement it is attached to, nothing more. If the statement is wrong, a flawless
proof is worth nothing. The levels before this one showed you how such flaws
look: junk values, a missing hypothesis, a notion that is too permissive.

An AI assistant was asked to formalise and prove Goldbach's conjecture:

  "Every even integer greater than 2 is the sum of two primes."

It came back with the statement and proof below. Both compile, and
there is no `sorry`.
-/
import Mathlib.Tactic

namespace L29

def IsPrime (p : Nat) : Prop := 2 ≤ p ∧ ∀ d, d ∣ p → d = 1 ∨ d = p

theorem ai_goldbach :
    ∀ n, 2 < n → n % 2 = 0 → ∃ p q, IsPrime p ∧ IsPrime q → p + q = n :=
  fun _ _ _ => ⟨0, 0, fun h => absurd h.1.1 (by decide)⟩

/-
Something is off: an open problem should not have a one-line proof.

## Your task

Write the faithful statement, but **parametrised by the notion of
"prime"**: `GoldbachFor P` should say "every even integer > 2 is the sum
of two numbers satisfying `P`". Then `GoldbachFor IsPrime` is the real
conjecture.

Why parametrise? You can't test a statement nobody can prove. You *can*
test it in toy worlds where you know the answer: what if every number
were "prime"? What if none were? A faithful statement has to give the
right answer in every one of these worlds. The referee checks several
such worlds, including the real one.

Start by reading the AI's statement the way Lean does: which parts do `∃`,
`∧` and `→` group together?
-/

def GoldbachFor (P : Nat → Prop) : Prop :=
  sorry

end L29
