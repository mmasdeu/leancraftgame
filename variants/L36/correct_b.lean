def triSum (n : ℕ) : ℕ := ∑ i ∈ Finset.range (n + 1), i
def triFormula (n : ℕ) : ℕ := n * (n + 1) / 2
def pairs (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, ∑ j ∈ Finset.range i, 1
def cubeSum (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, (i + 1) ^ 3
def cubeFormula (n : ℕ) : ℕ := (∑ i ∈ Finset.Icc 1 n, i) ^ 2
def sameParity (n : ℕ) : ℕ := (Finset.filter (fun p => p.2 < p.1 ∧ (p.1 + p.2) % 2 = 0) (Finset.range n ×ˢ Finset.range n)).card
def geom (n : ℕ) : ℚ := ∑ i ∈ Finset.range n, ((1 : ℚ) / 2) ^ i
def geomFormula (n : ℕ) : ℚ := 2 - (1 / 2 : ℚ) ^ n * 2
def meanSquare (n : ℕ) : ℚ := (∑ i ∈ Finset.range n, ((i ^ 2 : ℕ) : ℚ)) / (n : ℚ)
