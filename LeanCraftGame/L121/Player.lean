/-
# Spot the bug: sums

A colleague wrote four sums and counts. They compile, they look reasonable,
and each one is wrong.

```lean
-- 1 + 2 + … + n
def triangle (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i

-- the number of positive divisors of n
def numDivisors (n : ℕ) : ℕ := (Finset.filter (fun d => d ∣ n) (Finset.Ico 1 n)).card

-- the number of primes that are at most n
def primesUpTo (n : ℕ) : ℕ := (Finset.filter (fun p => Nat.Prime p) (Finset.range n)).card

-- the sum of the squares of the even numbers below n
def evenSquares (n : ℕ) : ℕ := (∑ i ∈ Finset.filter (fun i => i % 2 = 0) (Finset.range n), i) ^ 2
```

## How to hunt

* **Write out the set.** For a small `n`, list the elements of the `Finset`
  (`range`, `Icc`, `Ico`) and compare them with what the comment asks for.
* **Check both ends.** Is the first element included? Is the last?
* **Compute by hand** the right answer and the colleague's answer on the same
  small `n`.
* **Look at the brackets.** Is the filter, the power or the sum applied to the
  right thing? A bug that needs two nonzero terms to appear will not show on
  `n = 1`, or even `n = 3`.

## Your task

Give one input on which each function is wrong. Small numbers are best: they
make the referee's job easy.
-/
namespace L121

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

end L121
