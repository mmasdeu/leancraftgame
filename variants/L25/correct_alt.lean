def gauss (n : ℕ) : ℕ := ∑ k ∈ Finset.Icc 0 n, k
def fact (n : ℕ) : ℕ := ∏ i ∈ Finset.range n, (i + 1)
def pairsLt (n : ℕ) : ℕ := ((Finset.range n).powerset.filter (fun s => s.card = 2)).card
statement gauss_formula : ∀ m : ℕ, ∑ j ∈ Finset.range (m + 1), j = (m + 1) * m / 2
statement nicomachus {n : ℕ} : (∑ i ∈ Finset.range (n + 1), i) ^ 2 = ∑ i ∈ Finset.range (n + 1), i ^ 3
