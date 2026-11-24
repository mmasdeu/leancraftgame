/-
# Sums

Recursion (the Foundations world) defines sums one term at a time. Mathlib
has big operators instead:

```lean
def sumOfDoubles (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, 2 * i
```

`Finset.range n` is the finite set `{0, 1, …, n - 1}`, **without `n`**, and
`∑ i ∈ s, f i` is the sum of `f i` over the finite set `s` (type `\sum`).
Intervals come in four flavours: `Finset.Icc a b = [a, b]`,
`Finset.Ico a b = [a, b)`, `Finset.Ioc`, `Finset.Ioo`. The commonest bug in
finite sums is an off-by-one error in the range, and the cure is to test
the boundary: what is the sum for `n = 0`? (The empty sum is `0`.)

A `Finset` is a *finite* set, with a computable list of elements underneath;
this is what lets the referee evaluate your sums. In the Topology world,
finite spaces are built from `Finset`s for the same reason.

## Your task

Define the four sums. Read the comments carefully: which ends are included?
-/
namespace L34

-- 2 * 0 + 2 * 1 + … + 2 * (n - 1)     (already done)
def sumOfDoubles (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, 2 * i

-- the sum of the first n squares: 1² + 2² + … + n²       (squares 4 is 30)
def squares (n : ℕ) : ℕ := sorry

-- the sum of the first n odd numbers: 1 + 3 + … + (2n - 1)   (oddSum 3 is 9)
def oddSum (n : ℕ) : ℕ := sorry

-- the sum of all the numbers below n: 0 + 1 + … + (n - 1)    (sumBelow 5 is 10)
def sumBelow (n : ℕ) : ℕ := sorry

-- a + (a + 1) + … + (b - 1): `b` itself is not added    (sumBetween 3 6 is 12)
def sumBetween (a b : ℕ) : ℕ := sorry

end L34
