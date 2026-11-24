/-
# Spot the bug: sums

Four functions from a colleague, each off by a little: a range that stops
one short, a divisor count that forgets a divisor, a prime count that stops
before `n`, a sum of squares that squares the sum.

For each one, find an `n` on which it is wrong. The fastest way is to
evaluate the two sides on small inputs (`0`, `1`, `2`, …) in your head or
with `#eval`, and stop at the first disagreement. The boundary cases `0` and
`1`, and the inputs that are themselves divisors or primes, are where
off-by-one errors live.

`(∑ i, a i)² ≠ ∑ i, (a i)²` in general: the cross terms are missing. That
inequality is the starting point of the Cauchy–Schwarz inequality.

## Your task

Give one input per function. Each test checks that the colleague's function
and the right one disagree there.
-/
namespace L38

-- The colleague's code, to read (the referee uses its own copy).
def triangle (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i
def numDivisors (n : ℕ) : ℕ := (Finset.filter (fun d => d ∣ n) (Finset.Ico 1 n)).card
def primesUpTo (n : ℕ) : ℕ := (Finset.filter (fun p => Nat.Prime p) (Finset.range n)).card
def evenSquares (n : ℕ) : ℕ := (∑ i ∈ Finset.filter (fun i => i % 2 = 0) (Finset.range n), i) ^ 2

-- an input on which `triangle` is wrong
def tn : ℕ := sorry

-- an input on which `numDivisors` is wrong
def dn : ℕ := sorry

-- an input on which `primesUpTo` is wrong
def pn : ℕ := sorry

-- an input on which `evenSquares` is wrong
def en : ℕ := sorry

end L38
