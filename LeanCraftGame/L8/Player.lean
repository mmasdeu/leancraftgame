/-
# And, or, not

Statements combine with the connectives

| | Lean | type it as |
|---|---|---|
| and | `P ∧ Q` | `\and` |
| or (inclusive) | `P ∨ Q` | `\or` |
| not | `¬ P` | `\not` |

`¬` binds tightest, then `∧`, then `∨`: `¬ P ∧ Q` is `(¬ P) ∧ Q`. When in
doubt, add brackets.

Mathlib provides primality, `Nat.Prime p`, and divisibility, `a ∣ b` (type
`\|` or `\dvd`; it is not the bar `|` of your keyboard). The referee can
decide both for small numbers.

Mathematicians' "or" is inclusive. "Exactly one of" needs more: "at least
one, and not both".

The boundary again: `1` is neither prime nor composite. "Not prime" is not
the same as "composite", and the difference is exactly the numbers `0` and
`1`, which every theorem about factorisation has to exclude.

## Your task

Define the four predicates with `∧`, `∨`, `¬`, `Nat.Prime` and `∣`.
-/

namespace L8

-- p and 2p + 1 are both prime (Sophie Germain)
def IsSophieGermain (p : Nat) : Prop := sorry

-- p and p + 2 are both prime
def IsTwinPrime (p : Nat) : Prop := sorry

-- n > 1 and n is not prime
def IsComposite (n : Nat) : Prop := sorry

-- n is divisible by 2 or by 3, but not by both
def ExactlyOneOf23 (n : Nat) : Prop := sorry

end L8
