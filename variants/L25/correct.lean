def gauss (n : ℕ) : ℕ := ∑ i ∈ Finset.range (n + 1), i
def fact (n : ℕ) : ℕ := ∏ i ∈ Finset.Icc 1 n, i
def pairsLt (n : ℕ) : ℕ := ((Finset.range n ×ˢ Finset.range n).filter (fun p => p.1 < p.2)).card
statement gauss_formula (n : ℕ) : ∑ i ∈ Finset.range (n + 1), i = n * (n + 1) / 2
statement nicomachus (n : ℕ) : ∑ i ∈ Finset.range (n + 1), i ^ 3 = (∑ i ∈ Finset.range (n + 1), i) ^ 2
