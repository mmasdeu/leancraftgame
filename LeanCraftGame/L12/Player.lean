/-
# Integers and casts

On paper, `ℕ ⊂ ℤ ⊂ ℚ ⊂ ℝ`, and `3` is the same object in all four. In Lean
they are four different types, and `3 : ℕ` and `3 : ℤ` are different terms.
To use a natural number `a` as an integer you **cast** it: `(a : ℤ)`, which
Lean displays as `↑a`.

Where the cast goes changes the meaning:

* `((a - b : ℕ) : ℤ)` subtracts in `ℕ` (truncating at `0`) and then casts:
  for `a = 3, b = 5` it is `0`;
* `(a : ℤ) - (b : ℤ)` casts first and subtracts in `ℤ`: it is `-2`.

Casting is the formal shadow of a step mathematicians never write down:
"regard `a` as an integer". The rule of thumb is **cast early**: move to the
type where the operation behaves, then compute.

Integers have their own pitfalls. Division and remainder on `ℤ` are
Euclidean: `(-7) / 2 = -4` and `(-7) % 2 = 1`, so the remainder modulo `2` is
always `0` or `1`, also for negative numbers (other languages say `-1`).
`Int.natAbs x` is the absolute value of `x` as a natural number.

## Your task

Define `diff`, `gap` and `IsOddInt`.
-/

namespace L12

-- a - b as an integer, for natural numbers a and b      (diff 3 5 = -2)
def diff (a b : ℕ) : ℤ := sorry

-- the distance |a - b| between two integers, as a natural number   (gap 3 (-4) = 7)
def gap (a b : ℤ) : ℕ := sorry

-- x is an odd integer (positive or negative)
def IsOddInt (x : ℤ) : Prop := sorry

end L12
