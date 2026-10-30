/-
# Filters and counting

Last time you added up *all* the numbers of a `Finset`. Often you want only
some of them, or you want to *count* them.

## Keeping some elements: `Finset.filter`

`Finset.filter p s` keeps the elements of `s` that satisfy the condition `p`.
The condition is written as a little function, `fun i => …`, read "the `i` such
that …":

```lean
-- the even numbers below n:  {0, 2, 4, …}
def evenSet (n : ℕ) : Finset ℕ := Finset.filter (fun i => i % 2 = 0) (Finset.range n)
```

The result is again a `Finset`, so you can add it up, or count it.

## Counting: `.card`

`s.card` is the number of elements of `s` (dot notation, as in "Using
Mathlib": it means `Finset.card s`). With the set above, `(evenSet 7).card` is
`4`, for `0, 2, 4, 6`.

## Sums over a filter

```lean
-- the sum of the odd numbers below n
def sumOdds (n : ℕ) : ℕ := ∑ i ∈ Finset.filter (fun i => i % 2 = 1) (Finset.range n), i
```

Another way to say the same thing is to put an `if` *inside* the sum, with the
value `0` for the elements you skip:
`∑ i ∈ Finset.range n, if i % 2 = 1 then i else 0`. The `0`s add nothing.

## Products: `∏`

`∏` (type `\prod`) multiplies instead of adding. The empty product is `1`
(the number that multiplies nothing), just as the empty sum is `0`:

```lean
-- 2 * 3 * … * n  (and 1 for n = 0 and n = 1)
def prodFrom2 (n : ℕ) : ℕ := ∏ i ∈ Finset.Icc 2 n, i
```

## Your task

`evenSet` and `sumOdds` are done. Define the five functions below. Remember
the end points: does your set contain `0`? Does it contain `n`?
-/
namespace L118

-- the even numbers below n (already done)
def evenSet (n : ℕ) : Finset ℕ := Finset.filter (fun i => i % 2 = 0) (Finset.range n)

-- the sum of the odd numbers below n (already done)
def sumOdds (n : ℕ) : ℕ := ∑ i ∈ Finset.filter (fun i => i % 2 = 1) (Finset.range n), i

-- how many positive numbers divide n         (numDivisors 12 is 6: 1, 2, 3, 4, 6, 12)
def numDivisors (n : ℕ) : ℕ := sorry

-- how many primes are below n                (countPrimes 10 is 4: 2, 3, 5, 7)
def countPrimes (n : ℕ) : ℕ := sorry

-- the product 1 * 2 * … * n                  (fact 4 is 24)
def fact (n : ℕ) : ℕ := sorry

-- the sum of the numbers below n that are multiples of 3 or of 5
-- (multiples3or5 10 is 23: 3 + 5 + 6 + 9)
def multiples3or5 (n : ℕ) : ℕ := sorry

-- n is perfect: n is positive and equals the sum of its divisors that are
-- smaller than n                             (6 = 1 + 2 + 3 is perfect)
def IsPerfect (n : ℕ) : Prop := sorry

end L118
