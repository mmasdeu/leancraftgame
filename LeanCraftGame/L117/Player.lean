/-
# Sums

How do you add up a long list of numbers in Lean? With a **big sum**, written
with the symbol `∑` (type `\sum`):

```lean
def sumOfDoubles (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, 2 * i
```

Read it piece by piece:

* `∑` says "add up".
* `i ∈ Finset.range n` says "let `i` run through the numbers of
  `Finset.range n`" (`∈` is typed `\in`, as in "Sets"). The name `i` is yours.
* After the comma comes the formula to add up, for each `i`.

So `sumOfDoubles 4` is `2 * 0 + 2 * 1 + 2 * 2 + 2 * 3`, which is `12`.

## Finite sets: `Finset`

A `Set ℕ` can be infinite, so there is no way to add up its elements. A
**`Finset ℕ`** is a *finite* set of natural numbers, and its elements can be
added up. Three ways to build one:

* `Finset.range n` is `{0, 1, …, n - 1}`. It has `n` elements and does **not**
  contain `n`. This is the classic off-by-one trap: `Finset.range 4` stops at 3.
* `Finset.Icc a b` is `{a, a + 1, …, b}`: **both** ends are included
  (`Icc` is "interval, closed, closed").
* `Finset.Ico a b` is `{a, …, b - 1}`: `a` is included, `b` is not
  (`Ico` is "closed, open"). `Finset.range n` is the same as `Finset.Ico 0 n`.

If `b < a` the set `Finset.Icc a b` is empty, and so is `Finset.Ico a b` when
`b ≤ a`.

## The empty sum

Adding up *nothing* gives `0`. So `∑ i ∈ Finset.range 0, 2 * i` is `0`. This is
not a special case you have to code: it is what the notation means.

## Careful

* Everything after the comma belongs to the sum, up to the end of the line (or
  the closing bracket). Add brackets when you want the sum to stop earlier.
* Natural subtraction and division still behave as in "Functions".

## Your task

`sumOfDoubles` is done. Define the other four sums. The comments give examples.
-/
namespace L117

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

end L117
