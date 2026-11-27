/-
# Big operators and counting

*In level 22 you summed `0 + 1 + ⋯ + n` by recursion, with `sumTo`. Noor would rather
write such sums the way Mathlib does, so that the library's identities can be stated and
compared, and asks for Gauss's and Nicomachus's formulas in that form.*

Mathematics is full of sums and products over finite sets. Mathlib writes them with
**big operators**:

```lean
∑ i ∈ Finset.range 5, i ^ 2                    -- 0 + 1 + 4 + 9 + 16 = 30
∏ i ∈ Finset.Icc 1 4, i                        -- 1 · 2 · 3 · 4 = 24
∑ p ∈ (Finset.range 10).filter Nat.Prime, p    -- 2 + 3 + 5 + 7 = 17
```

Read `∑ i ∈ s, f i` as "the sum of `f i` for `i` in `s`" (type `\sum` and `\prod`). The
variable `i` is bound: `∑ j ∈ s, f j` is the same sum. An empty sum is `0`, an empty
product is `1`: that is why the `fac 0` of level 22 is `1`.

## Counting with finsets

To count objects, build the finset of the objects and take its `card`. For instance, the
pairs `(i, j)` with `i, j < 3` form the product `range 3 ×ˢ range 3` (type `\times\^s`,
or copy it), and

```lean
((Finset.range 3 ×ˢ Finset.range 3).filter (fun p => p.1 = p.2)).card   -- 3
```

counts the pairs on the diagonal. `p.1` and `p.2` are the two coordinates of a pair.

## Stating identities

Famous identities are statements about sums. Gauss's formula says that
`0 + 1 + ⋯ + n = n (n + 1) / 2`; Nicomachus's that `0³ + 1³ + ⋯ + n³` is the square of
`0 + 1 + ⋯ + n`. "From 0 to `n`, `n` included" is `Finset.range (n + 1)`: write the
sums of the statements that way, as the referee compares the shapes.

## Your task

Three definitions, and two statements (no proofs: the referee knows the theorems).
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
