def triSum (n : ℕ) : ℕ := ∑ i ∈ Finset.range (n + 1), i
def triFormula (n : ℕ) : ℕ := n * (n + 1) / 2
def pairs (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, ∑ j ∈ Finset.range i, 1
def cubeSum (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i ^ 3
def cubeFormula (n : ℕ) : ℕ := (n * (n + 1) / 2) ^ 2
def sameParity (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, ∑ j ∈ Finset.range i, if (i + j) % 2 = 0 then 1 else 0
def geom (n : ℕ) : ℚ := ∑ i ∈ Finset.range n, (1 / 2 : ℚ) ^ i
def geomFormula (n : ℕ) : ℚ := 2 - 2 * (1 / 2 : ℚ) ^ n
def meanSquare (n : ℕ) : ℚ := (∑ i ∈ Finset.range n, (i : ℚ) ^ 2) / n
