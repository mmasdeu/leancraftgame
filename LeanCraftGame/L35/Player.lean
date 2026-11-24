/-
# Counting

To count the elements of a finite set with a property, select them and
take the cardinality:

```lean
def evenSet (n : ℕ) : Finset ℕ := Finset.filter (fun i => i % 2 = 0) (Finset.range n)
```

`Finset.filter p s` keeps the elements of `s` that satisfy `p`, and
`s.card` is the number of elements. (This is "filter" in the sense of
selecting; the *filters* of topology, families of sets closed upwards and
under intersections, are something else and come in the Topology world.)

Arithmetic functions are counts and sums over divisors and primes:

* the number of divisors `τ(n)`: `τ(12) = 6`; and `τ(0)`? Every number
  divides `0`, so the formula you write must decide what to do with it;
* the prime-counting function `π(n)`, here the number of primes below `n`;
* `n!` as a product `∏ i ∈ Finset.Icc 1 n, i` (type `\prod`);
* **perfect numbers**, from scratch: `n` is the sum of its divisors smaller
  than `n`.

## Your task

Define the five functions. Each comment says which numbers are included.
-/
namespace L35

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

end L35
