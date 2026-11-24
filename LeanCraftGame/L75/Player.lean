/-
# The AI proved Goldbach!

Goldbach's conjecture: every even number greater than `2` is a sum of two
primes. Checked up to `4·10¹⁸`, unproved. The AI's statement is accepted by
Lean with a three-line proof. Read it the way Lean parses it:

`∃ p q, IsPrime p ∧ IsPrime q → p + q = n`

The arrow binds more loosely than `∧`, so this is "there are `p`, `q` such
that, *if* both are prime, *then* `p + q = n`": choose `p = q = 0`, which
are not prime, and the implication is vacuously true. The Logic world's
lesson about `∃ n, P n → Q n`, at the scale of a famous conjecture.

The final test of a statement is not whether it is proved; it is whether it
gives the right answer in every world where you know the answer. A
statement parametrised by the notion of "prime" can be checked in worlds
where everything is prime, where nothing is, where only `2` is, … and only
then trusted in the real one.

You have now written definitions for numbers, sequences, sets, structures
and spaces, and you have learned to break other people's. That is the
skill that remains valuable when proofs are free.
-/
import Mathlib.Tactic

namespace L75

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

end L75
