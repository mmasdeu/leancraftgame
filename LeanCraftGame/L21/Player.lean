/-
# Challenge: periodicity

The decimal expansion of a rational number is **eventually periodic**:
`1/6 = 0.1666…`, `1/7 = 0.142857142857…`. The orbit of every number under
the Collatz map (as far as anyone has checked) ends in the cycle `4, 2, 1`.
Periodicity is a statement with several quantifiers, and the order and the
side conditions decide everything.

* `u` is **periodic** when there is a period `p > 0` with `u (n + p) = u n`
  for every `n`. Without `p > 0`, every sequence would be periodic with
  period `0`.
* `u` is **eventually constant** when from some index on it equals one
  fixed value.
* `u` **has a maximum** when some term is at least as large as every term.
  `n % 3` has one, `n` has none. For sequences of natural numbers, bounded
  implies a maximum (there are finitely many possible values); for rational
  sequences such as `1 - 1/(n + 1)` it does not.
* `u` is **eventually periodic** when it becomes periodic from some index on.

## Your task

Define the four predicates. Count the quantifiers in each before you write
it, and decide where the conditions `p > 0` and `n ≥ N` go.
-/
namespace L21

-- there is a period p > 0 with u (n + p) = u n for every n
def Periodic (u : ℕ → ℕ) : Prop := sorry

-- from some index on, u is equal to one fixed value
def EventuallyConstant (u : ℕ → ℕ) : Prop := sorry

-- some term is at least as large as all the terms
def HasMaximum (u : ℕ → ℕ) : Prop := sorry

-- from some index on, u repeats itself with some period p > 0
def EventuallyPeriodic (u : ℕ → ℕ) : Prop := sorry

end L21
