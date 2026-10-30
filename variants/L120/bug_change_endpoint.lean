def telescope (n : ℕ) : ℚ := ∑ i ∈ Finset.Icc 1 n, 1 / ((i : ℚ) * (i + 1))
def sumPlusOne (n : ℕ) : ℕ := (∑ i ∈ Finset.range n, i) + 1
def rangeSum (a b : ℕ) : ℕ := ∑ i ∈ Finset.Icc a b, i
def totalChange (a : ℕ → ℕ) (n : ℕ) : ℕ := ∑ i ∈ Finset.range (n + 1), ((a (i + 1) - a i) + (a i - a (i + 1)))
def floorSum (n : ℕ) : ℕ := ∑ i ∈ Finset.Icc 1 n, n / i
