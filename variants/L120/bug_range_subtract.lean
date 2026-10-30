def telescope (n : ℕ) : ℚ := ∑ i ∈ Finset.Icc 1 n, 1 / ((i : ℚ) * (i + 1))
def sumPlusOne (n : ℕ) : ℕ := (∑ i ∈ Finset.range n, i) + 1
def rangeSum (a b : ℕ) : ℕ := ∑ i ∈ Finset.range (b + 1), i - ∑ i ∈ Finset.range a, i
def totalChange (a : ℕ → ℕ) (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, ((a (i + 1) - a i) + (a i - a (i + 1)))
def floorSum (n : ℕ) : ℕ := ∑ i ∈ Finset.Icc 1 n, n / i
