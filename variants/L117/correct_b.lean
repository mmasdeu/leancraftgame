def sumOfDoubles (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, 2 * i
def squares (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, (i + 1) ^ 2
def oddSum (n : ℕ) : ℕ := ∑ i ∈ Finset.Icc 1 n, (2 * i - 1)
def sumBelow (n : ℕ) : ℕ := ∑ i ∈ Finset.Ico 0 n, i
def sumBetween (a b : ℕ) : ℕ := ∑ i ∈ Finset.Icc a (b - 1), i
