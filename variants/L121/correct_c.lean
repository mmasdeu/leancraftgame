def triangle (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, i
def numDivisors (n : ℕ) : ℕ := (Finset.filter (fun d => d ∣ n) (Finset.Ico 1 n)).card
def primesUpTo (n : ℕ) : ℕ := (Finset.filter (fun p => Nat.Prime p) (Finset.range n)).card
def evenSquares (n : ℕ) : ℕ := (∑ i ∈ Finset.filter (fun i => i % 2 = 0) (Finset.range n), i) ^ 2

def tn : ℕ := 5
def dn : ℕ := 8
def pn : ℕ := 11
def en : ℕ := 7
