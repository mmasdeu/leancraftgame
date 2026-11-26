def divs (n : ℕ) : Finset ℕ := (Finset.Icc 1 n).filter (· ∣ n)
def squaresUpTo (n : ℕ) : Finset ℕ := (Finset.Icc 0 n).image (fun i => i * i)
def subsetsOfSize (s : Finset ℕ) (k : ℕ) : Finset (Finset ℕ) := Finset.powersetCard k s
def numFns : ℕ := 2 ^ 3
