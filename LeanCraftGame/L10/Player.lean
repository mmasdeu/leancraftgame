/-
# Integers and casts

Natural numbers have no negatives, which is why `3 - 5` is `0` in `ℕ`. The
**integers** `ℤ` (type `\Z`, or write `Int`) are …, -2, -1, 0, 1, 2, …, and
their subtraction is the real one. (`ℕ` is another name for `Nat`; type `\N`.)

* `(3 : ℤ)` means "3, as an integer". This is a *type ascription*.
* `(3 : ℤ) - 5` is `-2`.

## Casts

A natural number `n : ℕ` can be used where an integer is expected: write
`(n : ℤ)`. Lean then inserts a **cast**, displayed `↑n`. *Where* the cast goes
changes the result:

```lean
def good (a b : ℕ) : ℤ := (a : ℤ) - (b : ℤ)   -- good 3 5 = -2
def bad  (a b : ℕ) : ℤ := ((a - b : ℕ) : ℤ)   -- bad 3 5 = 0 : subtracted in ℕ, then cast
```

`(a - b : ℤ)` also works: Lean elaborates the whole expression as an integer
and casts `a` and `b` first.

## Dot notation and two more junk values

* `x.natAbs` is the absolute value of an integer `x`, as a natural number.
  It is short for `Int.natAbs x`: since `x` is an `Int`, Lean looks for
  `natAbs` among the functions named `Int.something`.
* `x.toNat` turns an integer into a natural number, but every negative number
  becomes `0`. Like `3 - 5 = 0` in `ℕ`, this is a *junk value*: a function
  must return something, so Lean returns 0.

## Your task

Define `diff`, `distance` and `IsNegative`.
-/
namespace L10

-- a minus b, as an integer        (diff 3 5 is -2)
def diff (a b : ℕ) : ℤ := sorry

-- the distance between two integers, as a natural number   (distance 3 (-4) is 7)
def distance (a b : ℤ) : ℕ := sorry

-- x is negative
def IsNegative (x : ℤ) : Prop := sorry

end L10
