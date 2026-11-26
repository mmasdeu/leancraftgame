def divs (n : ℕ) : Finset ℕ := (Finset.range (n + 1)).filter (fun d => d ∣ n)
def squaresUpTo (n : ℕ) : Finset ℕ := (Finset.range n).image (fun i => i ^ 2)
def subsetsOfSize (s : Finset ℕ) (k : ℕ) : Finset (Finset ℕ) := s.powerset.filter (fun t => t.card = k)
def numFns : ℕ := Fintype.card (Fin 3 → Bool)
