/-
# Challenge: truncated arithmetic

Four functions where the junk values of `ℕ` and `ℚ` are waiting for you.
Everything you need was in "Integers and casts" and "Division by zero".

* `(a - b : ℕ)` stops at 0, and `a / b` on `ℕ` rounds **down** (and
  `a / 0` is `0`).
* A cast must happen **before** the operation it is meant to protect:
  `((a - b : ℕ) : ℤ)` is too late, `(a : ℤ) - b` is right.
* `(a : ℚ) / b` is a true fraction, but `((a / b : ℕ) : ℚ)` divides first
  and casts afterwards.
* `if x < 0 then … else …` also works on `ℤ`, and `if` can be nested.

## Your task

* `absDiff a b`: the distance between two naturals, as a natural.
* `signum x`: -1, 0 or 1 according to the sign of the integer `x`.
* `ratio a b`: the fraction `a / b` as a rational, but 0 when `b` is 0.
* `percent a b`: what percentage `a` is of `b`, **rounded to the nearest
  whole number, with halves rounded up**, as a natural. `percent 1 8` is 13
  (12.5 rounds up), and it is 0 when `b` is 0. Stay in `ℕ` and arrange for the
  division to round the way you want: adding half of the divisor before
  dividing does that.

Hidden tests will hunt for every inexact value.
-/
namespace L103

-- |a - b|                       (absDiff 3 5 is 2, absDiff 5 3 is 2)
def absDiff (a b : ℕ) : ℕ := sorry

-- the sign of x                  (signum (-7) is -1, signum 0 is 0, signum 4 is 1)
def signum (x : ℤ) : ℤ := sorry

-- a divided by b, exactly; 0 if b is 0       (ratio 1 2 is 1/2)
def ratio (a b : ℕ) : ℚ := sorry

-- 100 * a / b rounded to the nearest whole number, halves up    (percent 2 3 is 67)
def percent (a b : ℕ) : ℕ := sorry

end L103
