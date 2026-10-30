def telescope (n : ℕ) : ℚ := ∑ i ∈ Finset.range n, (1 / (i + 1 : ℚ) - 1 / (i + 2 : ℚ))
def sumPlusOne (n : ℕ) : ℕ := 1 + ∑ i ∈ Finset.Ico 0 n, i
def rangeSum (a b : ℕ) : ℕ := ∑ i ∈ Finset.Ico a (b + 1), i
def totalChange (a : ℕ → ℕ) (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, (if a i ≤ a (i + 1) then a (i + 1) - a i else a i - a (i + 1))
def floorSum (n : ℕ) : ℕ := ∑ i ∈ Finset.Icc 0 n, n / i
