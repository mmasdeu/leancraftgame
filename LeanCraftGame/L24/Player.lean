/-
# Finset and Fintype

MIL's chapter on discrete mathematics starts with **finite sets**. Mathlib has two
notions of set, and the difference matters:

* `Set α` is a predicate on `α`: `{n | Even n}` may be infinite, and Lean cannot
  compute with it.
* `Finset α` is a *finite* set that Lean can compute with: it can list its elements,
  count them (`s.card`, also written `#s`), and decide whether `3 ∈ s`.

## Building finsets

```lean
Finset.range 5                       -- {0, 1, 2, 3, 4}: 5 itself is NOT in it
Finset.Icc 1 5                       -- {1, 2, 3, 4, 5}: both ends included
Finset.Ico 1 5                       -- {1, 2, 3, 4}
(Finset.range 10).filter (fun n => n % 3 = 0)        -- {0, 3, 6, 9}
(Finset.range 4).image (fun n => 2 * n)              -- {0, 2, 4, 6}
({1, 2, 3} : Finset ℕ).powerset                      -- all 8 subsets
({1, 2, 3} : Finset ℕ).card                          -- 3
```

* `s.filter p` keeps the elements that satisfy `p`.
* `s.image f` applies `f` to every element (and removes repetitions).
* `s.powerset` is the finset of all subsets of `s`: a `Finset (Finset α)`.

`Finset.range n` is the most used finset in Mathlib, and the most common source of
off-by-one errors: it stops **before** `n`.

## Fintype

A *type* can be finite too: `Bool`, `Fin n = {0, …, n-1}`, products and function types
between finite types. For those, `Finset.univ` is the finset of all elements, and
`Fintype.card α` counts them:

```lean
Fintype.card (Fin 3)          -- 3
Fintype.card (Fin 3 × Bool)   -- 6
```

## Your task

Write the four definitions. The referee computes with them.
-/
import Mathlib.Tactic

namespace L24

-- the divisors of n among 0, 1, …, n     (divs 12 = {1, 2, 3, 4, 6, 12})
def divs (n : ℕ) : Finset ℕ := sorry

-- the squares 0², 1², …, n², n included   (squaresUpTo 2 = {0, 1, 4})
def squaresUpTo (n : ℕ) : Finset ℕ := sorry

-- the subsets of s that have exactly k elements
def subsetsOfSize (s : Finset ℕ) (k : ℕ) : Finset (Finset ℕ) := sorry

-- the number of functions Fin 3 → Bool, computed with `Fintype.card`
def numFns : ℕ := sorry

end L24
