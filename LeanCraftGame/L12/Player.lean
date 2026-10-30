/-
# Spot the bug: numbers

Junk values are where definitions go wrong without anybody noticing: `3 - 5`
is `0` in `ℕ`, and `x / 0` is `0` in `ℚ`. A colleague, who has not played the
Numbers world, wrote:

```lean
-- the difference a - b, as an integer: diff 3 5 is -2
def diff (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)

-- y is the reciprocal of x: x * y = 1
def IsReciprocal (x y : ℚ) : Prop := y = 1 / x

-- the average of a and b
def average (a b : ℚ) : ℚ := a + b / 2
```

Each definition agrees with the intended meaning on *many* inputs. That is
what makes these bugs dangerous: a few random checks will not find them. Ask
instead: **where is the junk value?** Which subtraction can go below zero,
which division can be by zero, and where would the parentheses go?

## Your task

* `diffA`, `diffB`: two natural numbers with `diff diffA diffB ≠ diffA - diffB`
  (the second subtraction in `ℤ`).
* `recX`, `recY`: two rationals that `IsReciprocal` accepts, although
  `recX * recY ≠ 1`.
* `avgA`, `avgB`: two rationals with `average avgA avgB ≠ (avgA + avgB) / 2`.

A rational number is written like an integer, or as a fraction: `3`, `-2`,
`(1 / 2 : ℚ)`.
-/
namespace L12

-- The colleague's code, to read (the referee uses its own copy).
def diff (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)
def IsReciprocal (x y : ℚ) : Prop := y = 1 / x
def average (a b : ℚ) : ℚ := a + b / 2

-- diff gets these wrong
def diffA : ℕ := sorry
def diffB : ℕ := sorry

-- IsReciprocal accepts these, but recX * recY ≠ 1
def recX : ℚ := sorry
def recY : ℚ := sorry

-- average gets these wrong
def avgA : ℚ := sorry
def avgB : ℚ := sorry

end L12
