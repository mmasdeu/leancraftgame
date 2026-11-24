/-
# Spot the bug

A colleague wrote two functions. Both compile, both give the right answer
on the examples they tried, and both are wrong.

Before repairing code, **find an input where it fails**. Walk through every
branch of every `if`, and ask which inputs land there:

* `median3`: there are six orderings of three distinct numbers. In which
  branch does each one land, and does that branch return the middle value?
  (`median3 1 2 3`, `median3 3 1 2`, …)
* `daysInYear`: the Gregorian rule is "divisible by 4, except centuries,
  except centuries divisible by 400". 1900 was not a leap year, 2000 was.

A case analysis that misses a case is the commonest bug in mathematics as
in programming: a proof "by symmetry" that is not symmetric, a "without loss
of generality" that loses generality.

`min` and `max` exist in Lean, and the median of three numbers is
`max (min a b) (min (max a b) c)`.

## Your task

Repair both definitions. The referee checks `median3` on every triple of
numbers below 5 (all orderings, and ties), and `daysInYear` on famous years.
-/

namespace L6

-- A colleague's code. Repair it; keep the names and the types.

-- the median (middle value) of three numbers
def median3 (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else c)
  else (if a ≤ c then a else c)

-- the number of days in the year y of the Gregorian calendar
def daysInYear (y : Nat) : Nat :=
  if y % 4 = 0 then (if y % 100 = 0 then 365 else 366) else 365

end L6
