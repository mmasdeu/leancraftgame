/-
# Spot the bug: connectives

A colleague translated four definitions into Lean. Each compiles; each says
something other than what was meant. Your job is to prove it, the way a
referee proves a paper wrong: with a **counterexample**, an input on which
the definition and its intended meaning disagree.

Read each definition aloud, literally, connective by connective:

* `13 ≤ n ∨ n ≤ 19`: "at least 13, *or* at most 19". Which numbers fail
  that?
* `¬ Nat.Prime n`: what about the numbers that are neither prime nor
  composite?
* `¬ (2 ∣ a ∧ 2 ∣ b)` only looks at the prime 2.
* `¬ a % 2 = 0 ∧ b % 2 = 0`: where does the `¬` stop? (`¬` binds tighter
  than `∧`.)

Some definitions are **too weak** (they accept things they should reject)
and some are **too strong** (they reject things they should accept). Decide
which before hunting.

## Your task

For each definition, give an input where it gives the wrong answer. The
referee evaluates the colleague's definitions on your inputs (its own copy:
editing the definitions above changes nothing) and checks that your inputs
really are counterexamples.
-/

namespace L11

-- A colleague's definitions (to read: the referee uses its own copy).
def InRange (n : Nat) : Prop := 13 ≤ n ∨ n ≤ 19              -- meant: 13 ≤ n ≤ 19
def IsComposite (n : Nat) : Prop := ¬ Nat.Prime n               -- meant: composite
def Coprime (a b : Nat) : Prop := ¬ (2 ∣ a ∧ 2 ∣ b)            -- meant: gcd a b = 1
def BothOdd (a b : Nat) : Prop := ¬ a % 2 = 0 ∧ b % 2 = 0      -- meant: a and b odd

-- accepted by InRange, but not between 13 and 19
def r : Nat := sorry
-- accepted by IsComposite, but not composite
def c : Nat := sorry
-- accepted by Coprime, but with a common factor
def ca : Nat := sorry
def cb : Nat := sorry
-- two odd numbers that BothOdd rejects
def oa : Nat := sorry
def ob : Nat := sorry

end L11
