def sumOfDoubles (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, 2 * i
def squares (n : ℕ) : ℕ := ∑ i ∈ Finset.Icc 1 n, i ^ 2
def oddSum (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, (2 * i + 1)
def sumBelow (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i
def sumBetween (a b : ℕ) : ℕ := ∑ i ∈ Finset.range b, i - ∑ i ∈ Finset.range a, i
