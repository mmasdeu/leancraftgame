/-
# Challenge: Egyptian fractions

The scribes of the Rhind papyrus wrote every fraction as a sum of distinct
unit fractions: `5/6 = 1/2 + 1/3`. Whether every `4/n` is a sum of three unit
fractions (the Erdős–Straus conjecture) is still open.

Writing `1/a + 1/b` for natural numbers `a`, `b` needs care twice over:

* `1 / a` with `a : ℕ` is **natural-number division**: `1 / 2 = 0`. The
  fraction is `1 / (a : ℚ)`: cast before dividing.
* `1 / 0 = 0` in `ℚ`, so without the condition `a > 0`, the "Egyptian
  fraction" `1/0 + 1/3` would be `1/3`.

Also in this challenge: `absDiff` on `ℕ` (recall truncated subtraction),
the sign of an integer (three cases), and the exact ratio of two natural
numbers, which follows Mathlib's convention `a / 0 = 0`.

## Your task

Define the four functions and predicates. Watch the boundaries: `0`, equal
inputs, negative inputs.
-/

namespace L14

-- |a - b| for natural numbers
def absDiff (a b : ℕ) : ℕ := sorry

-- the sign of x: -1, 0 or 1
def signum (x : ℤ) : ℤ := sorry

-- a / b as an exact fraction (and 0 when b = 0, like Mathlib)
def ratio (a b : ℕ) : ℚ := sorry

-- x is the Egyptian fraction 1/a + 1/b with positive a and b
def IsEgyptian (x : ℚ) (a b : ℕ) : Prop := sorry

end L14
