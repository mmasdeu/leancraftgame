/-
# Spot the bug: numbers

Four definitions from a colleague, each with one of the traps of this
world: a late cast, a junk value, a precedence slip, and division in the
wrong type. For each, find inputs on which it disagrees with what was meant.

Questions to ask:

* **Where does each operation happen?** In `((a - b : ℕ) : ℤ)` the
  subtraction is done in `ℕ`, before the cast. When does that matter?
* **What does the definition say at `0`?** `1 / 0 = 0`.
* **How does it parse?** `a + b / 2` is `a + (b / 2)`.
* **Which `1 / a`?** Inside `(… : ℕ)`, `1 / a` is natural-number division.

Small inputs are best: the referee checks your claims by computation.

## Your task

Give the counterexamples. Each test is a claim about your inputs that must
be true.
-/

namespace L15

-- A colleague's definitions (to read: the referee uses its own copy).
def diff (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)                    -- meant: a - b in ℤ
def IsReciprocal (x y : ℚ) : Prop := y = 1 / x                 -- meant: x · y = 1
def average (a b : ℚ) : ℚ := a + b / 2                         -- meant: (a + b) / 2
def egypt (a b : ℕ) : ℚ := ((1 / a + 1 / b : ℕ) : ℚ)          -- meant: 1/a + 1/b in ℚ

-- diff gets these wrong
def diffA : ℕ := sorry
def diffB : ℕ := sorry
-- IsReciprocal accepts these, but recX · recY ≠ 1
def recX : ℚ := sorry
def recY : ℚ := sorry
-- average gets these wrong
def avgA : ℚ := sorry
def avgB : ℚ := sorry
-- egypt gets these wrong (both positive)
def egA : ℕ := sorry
def egB : ℕ := sorry

end L15
