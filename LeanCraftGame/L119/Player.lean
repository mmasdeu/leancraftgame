/-
# Closed forms

A sum such as `1 + 2 + … + n` has a **closed form**: a formula with no sum in
it, like `n * (n + 1) / 2`. Both define a function of `n`, and the two
functions agree. The referee cannot prove that for *all* `n`, but it can check
it for every `n` below 10, and any mistake shows up there.

```lean
def triSum (n : ℕ) : ℕ := ∑ i ∈ Finset.range (n + 1), i      -- 0 + 1 + … + n
def triFormula (n : ℕ) : ℕ := n * (n + 1) / 2                -- the closed form
```

Division in `ℕ` rounds down, but here `n * (n + 1)` is always even, so no
rounding happens. The order of operations does matter, though: `n * (n + 1) / 2`
is not `n * ((n + 1) / 2)`. Try `n = 2`.

## Double sums

The formula of a sum may be a sum itself. The inner set may depend on the outer
variable:

```lean
-- one for each pair j < i < n
def pairs (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, ∑ j ∈ Finset.range i, 1
```

Read it from the outside in: for each `i` below `n`, add up (one `1` for each
`j` below `i`). That is `0 + 1 + 2 + … + (n - 1)`.

## Sums of rational numbers

`ℚ` is the type of fractions (type `\Q`). Division in `ℚ` is exact:
`(1 / 2 : ℚ)` really is one half. Write the type next to a number to say which
kind it is, as in `(1 / 2 : ℚ) ^ i`. To use a natural number `i` as a rational,
write `(i : ℚ)`: this is a *cast*, as in "Integers and casts". The cast must
happen *before* the division, not after it.

## Your task

`triSum`, `triFormula` and `pairs` are done. Define the other six functions.
-/
namespace L119

-- 0 + 1 + … + n and its closed form (already done)
def triSum (n : ℕ) : ℕ := ∑ i ∈ Finset.range (n + 1), i
def triFormula (n : ℕ) : ℕ := n * (n + 1) / 2

-- the number of pairs j < i < n (already done)
def pairs (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, ∑ j ∈ Finset.range i, 1

-- the sum of the first n cubes: 1³ + 2³ + … + n³                (cubeSum 3 is 36)
def cubeSum (n : ℕ) : ℕ := sorry

-- its closed form: the square of 1 + 2 + … + n                 (cubeFormula 3 is 36)
-- (use the closed form of the previous sum, not a sum)
def cubeFormula (n : ℕ) : ℕ := sorry

-- the number of pairs j < i < n with i + j even, counted with a double sum
-- (sameParity 4 is 2: the pairs (0, 2) and (1, 3))
def sameParity (n : ℕ) : ℕ := sorry

-- 1 + 1/2 + 1/4 + … : the sum of (1/2)^i for i < n, as a rational
-- (geom 3 is 7/4)
def geom (n : ℕ) : ℚ := sorry

-- its closed form, without a sum                                 (geomFormula 3 is 7/4)
def geomFormula (n : ℕ) : ℚ := sorry

-- the mean of the squares 0², 1², …, (n - 1)², as a rational     (meanSquare 4 is 7/2)
def meanSquare (n : ℕ) : ℚ := sorry

end L119
