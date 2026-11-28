/-
# Finset and Fintype

*A new project: counting. Noor wants sets Lean can compute: the divisors of 12, the squares
up to `n²`, the subsets of a given size. The primes of level 15 form an infinite set Lean
can't list, so counting needs another kind of set.*

* `Set α` is a predicate. `{n | Nat.Prime n}` may be infinite; Lean can't compute with it.
* `Finset α` is a *finite* set Lean can compute with. It can list the elements, count them
  (`s.card`) and decide `3 ∈ s`.

## Building finsets

```lean
Finset.range 5                       -- {0, 1, 2, 3, 4}
Finset.Icc 1 5                       -- {1, 2, 3, 4, 5}: both ends included
Finset.Ico 1 5                       -- {1, 2, 3, 4}
(Finset.range 10).filter (fun n => n % 3 = 0)        -- {0, 3, 6, 9}
(Finset.range 20).filter Nat.Prime   -- {2, 3, 5, 7, 11, 13, 17, 19}: card 8
(Finset.range 4).image (fun n => 2 * n)              -- {0, 2, 4, 6}
({1, 2, 3} : Finset ℕ).powerset                      -- all 8 subsets
({1, 2, 3} : Finset ℕ).card                          -- 3
```

* `s.filter p` keeps the elements satisfying `p`. Lean must be able to check `p` on each
  element, as it can for `n % 3 = 0` or `Nat.Prime n`.
* `s.image f` applies `f` to each element and drops repeats, like `f '' s` (level 16).
* `s.powerset` is all subsets of `s`, a `Finset (Finset α)`.

Read the ends of a range carefully: they're the usual source of off-by-one errors.

## Fintype

Some types are finite: `Bool`, `Fin n = {0, …, n-1}`, and products and function types
of finite types. `Finset.univ` is all their elements, and `Fintype.card α` counts them:

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
