/-
# Challenge: finite sums

Five sums, each with a trap. Nothing new to learn, but nothing to take for
granted either. Before you type, write out the first few terms **by hand**:
which numbers does the sum run through, and what is the first and last term?

Things that have caught people before:

* `Finset.range n`, `Finset.Icc a b`, `Finset.Ico a b`: which end points belong?
* A sum over an empty set is `0`. What should your definition say there?
* In `ℕ`, subtraction stops at `0` and `/` rounds down. Both can happen
  *inside* the formula of a sum.
* The formula of `∑ i ∈ s, …` runs as far to the right as it can.
* A rational number built from natural numbers must be cast *before* dividing.

## Your task

Define the five functions below. The comments give examples; the tests also
look at other cases.
-/
namespace L120

-- the sum of 1 / (i * (i + 1)) for i = 1, …, n, as a rational
-- (telescope 2 is 1/2 + 1/6 = 2/3)
def telescope (n : ℕ) : ℚ := sorry

-- one more than the sum of the numbers below n        (sumPlusOne 4 is 0+1+2+3 + 1 = 7)
def sumPlusOne (n : ℕ) : ℕ := sorry

-- a + (a + 1) + … + b, both ends included; nothing to add when b < a
-- (rangeSum 3 5 is 12)
def rangeSum (a b : ℕ) : ℕ := sorry

-- how much the sequence a moves in total over its first n steps, up or down:
-- the sum of the distances between a i and a (i + 1), for i < n
-- (with a i = i % 3 and n = 6 the sequence is 0, 1, 2, 0, 1, 2, 0: total 8)
def totalChange (a : ℕ → ℕ) (n : ℕ) : ℕ := sorry

-- the sum of n / i (rounded down) for i = 1, …, n   (floorSum 4 is 4 + 2 + 1 + 1 = 8)
def floorSum (n : ℕ) : ℕ := sorry

end L120
