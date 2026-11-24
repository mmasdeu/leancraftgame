/-
# Closed forms

A **closed form** replaces a sum by a formula: `0 + 1 + ⋯ + n = n(n+1)/2`.
Proving such an identity is an induction; *finding* it is experiment, and
checking a candidate on many values is how one finds out whether it is worth
proving. Here the referee compares your sum and your formula.

Nicomachus's theorem, `1³ + 2³ + ⋯ + n³ = (1 + 2 + ⋯ + n)²`, is the kind of
identity that looks like a coincidence until one sees the picture.

Over `ℚ` the geometric series `1 + 1/2 + ⋯ + 1/2^(n-1) = 2 - 1/2^(n-1)`
needs fractions: write `(1/2 : ℚ) ^ i`, so that Lean does not divide in
`ℕ` (where `1 / 2 = 0`). A **mean** is a sum divided by a count, and the
count must be cast to `ℚ` before dividing.

Double sums count pairs: `∑ i ∈ range n, ∑ j ∈ range i, 1` is the number of
pairs `j < i < n`, i.e. `n(n-1)/2`.

## Your task

Define the sums and their closed forms as asked. Use a sum where the comment
asks for a sum and a formula where it asks for a formula: the referee checks
that they agree.
-/
namespace L36

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

end L36
