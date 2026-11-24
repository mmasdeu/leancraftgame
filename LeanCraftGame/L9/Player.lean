/-
# If, then

`P → Q` reads "if `P` then `Q`" (type `\to`). It is false in exactly one
situation: `P` true and `Q` false. In particular **a false hypothesis makes
an implication true**: "if 3 is divisible by 4, then 3 is even" is true,
vacuously. This convention is what makes "every element of the empty set is
green" true, and what lets a theorem with hypotheses be applied to the
cases it covers without worrying about the others.

The **converse** of `P → Q` is `Q → P`, a different statement: "4 ∣ n
implies 2 ∣ n" is true for every `n`, its converse is not. To refute a
statement about all `n`, one counterexample suffices.

`P ↔ Q` ("if and only if", type `\iff`) says that both directions hold.
Many theorems are equivalences: "`n²` is even iff `n` is even" (the
direction ← is the interesting one, and is the heart of the proof that
`√2` is irrational).

Precedence: `→` binds more loosely than `∧`, `∨` and `↔`... except that `↔`
is looser still: when in doubt, use brackets.

## Your task

Define the implications and the equivalence `SameParity`, and give a
counterexample to each false general claim.
-/

namespace L9

-- if 4 divides n then 2 divides n
def FourThenTwo (n : Nat) : Prop := sorry

-- the converse: if 2 divides n then 4 divides n
def TwoThenFour (n : Nat) : Prop := sorry

-- a number for which the converse fails
def breaksConverse : Nat := sorry

-- "a prime is odd": if p is prime then p is odd
def PrimeThenOdd (p : Nat) : Prop := sorry

-- the only number that breaks it
def breaksPrimeOdd : Nat := sorry

-- a and b have the same parity: a is even if and only if b is even
def SameParity (a b : Nat) : Prop := sorry

end L9
