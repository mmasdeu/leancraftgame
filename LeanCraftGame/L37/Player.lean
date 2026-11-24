/-
# Challenge: finite sums

Five sums with traps.

* A **telescoping** sum: `1/(i(i+1)) = 1/i - 1/(i+1)`, so
  `∑_{i=1}^n 1/(i(i+1)) = 1 - 1/(n+1)`. Mind where `i` starts: at `0` the
  first term would be `1/0 = 0` in Lean, silently.
* Shifting an index: `∑_{i<n} (i + 1) = 1 + 2 + ⋯ + n`.
* An interval with both ends included, which must be empty when `b < a`.
* **Total variation**: the sum of `|a(i+1) - a(i)|`. On `ℕ`, `|x - y|`
  needs care (truncated subtraction).
* `∑_{i=1}^n ⌊n/i⌋` counts the pairs `(i, k)` with `i·k ≤ n`, which is
  also `∑_{k ≤ n} τ(k)`: Dirichlet's divisor problem in miniature.

## Your task

Define the five sums. For each, check the first two values by hand before
you run the tests.
-/
namespace L37

-- the sum of 1 / (i * (i + 1)) for i = 1, …, n, as a rational
-- (telescope 2 is 1/2 + 1/6 = 2/3)
def telescope (n : ℕ) : ℚ := sorry

-- the sum of (i + 1) for i below n: 1 + 2 + … + n      (sumOfSucc 4 is 1+2+3+4 = 10)
def sumOfSucc (n : ℕ) : ℕ := sorry

-- a + (a + 1) + … + b, both ends included; nothing to add when b < a
-- (rangeSum 3 5 is 12)
def rangeSum (a b : ℕ) : ℕ := sorry

-- how much the sequence a moves in total over its first n steps, up or down:
-- the sum of the distances between a i and a (i + 1), for i < n
-- (with a i = i % 3 and n = 6 the sequence is 0, 1, 2, 0, 1, 2, 0: total 8)
def totalChange (a : ℕ → ℕ) (n : ℕ) : ℕ := sorry

-- the sum of n / i (rounded down) for i = 1, …, n   (floorSum 4 is 4 + 2 + 1 + 1 = 8)
def floorSum (n : ℕ) : ℕ := sorry

end L37
