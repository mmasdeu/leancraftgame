/-
# Big operators and counting

*In level 22 you wrote `sumTo` by recursion. Noor wants sums written the Mathlib way, so
identities can be stated and compared, starting with Gauss's and Nicomachus's formulas.*

Mathlib writes finite sums and products with **big operators**:

```lean
∑ i ∈ Finset.range 5, i ^ 2                    -- 0 + 1 + 4 + 9 + 16 = 30
∏ i ∈ Finset.Icc 1 4, i                        -- 1 · 2 · 3 · 4 = 24
∑ p ∈ (Finset.range 10).filter Nat.Prime, p    -- 2 + 3 + 5 + 7 = 17
```

`∑ i ∈ s, f i` is the sum of `f i` for `i` in `s` (type `\sum`, `\prod`). `i` is bound,
so `∑ j ∈ s, f j` is the same sum. An empty sum is `0`, an empty product `1`, which is why
`fac 0 = 1` in level 22.

## Counting

To count things, build their finset and take `card`. The pairs `(i, j)` with `i, j < 3`
form `range 3 ×ˢ range 3` (type `\times\^s`, or copy it), and

```lean
((Finset.range 3 ×ˢ Finset.range 3).filter (fun p => p.1 = p.2)).card   -- 3
```

counts the pairs on the diagonal. `p.1` and `p.2` are a pair's coordinates.

## Identities

Gauss: `0 + 1 + ⋯ + n = n (n + 1) / 2`. Nicomachus: `0³ + 1³ + ⋯ + n³` is the square of
`0 + 1 + ⋯ + n`. "From 0 to `n` included" is `Finset.range (n + 1)`. Write your sums that
way, since the referee compares shapes.

## Your task

Three definitions and two statements. No proofs.
-/
import Mathlib.Tactic

namespace L25

-- 0 + 1 + ⋯ + n   (n included)
def gauss (n : ℕ) : ℕ := sorry

-- n! = 1 · 2 · ⋯ · n, as a product ∏   (fact 0 = 1)
def fact (n : ℕ) : ℕ := sorry

-- the number of pairs (i, j) with i < j < n   (pairsLt 3 = 3: (0,1), (0,2), (1,2))
def pairsLt (n : ℕ) : ℕ := sorry

-- Gauss: for every natural number n, ∑ of i for i from 0 to n is n * (n + 1) / 2
statement gauss_formula : sorry

-- Nicomachus: for every n, the sum of i ^ 3 for i from 0 to n is
-- the square of the sum of i for i from 0 to n
statement nicomachus : sorry

end L25
