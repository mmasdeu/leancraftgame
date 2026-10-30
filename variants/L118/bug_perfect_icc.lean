def evenSet (n : ℕ) : Finset ℕ := Finset.filter (fun i => i % 2 = 0) (Finset.range n)
def sumOdds (n : ℕ) : ℕ := ∑ i ∈ Finset.filter (fun i => i % 2 = 1) (Finset.range n), i
def numDivisors (n : ℕ) : ℕ := (Finset.filter (fun d => d ∣ n) (Finset.Icc 1 n)).card
def countPrimes (n : ℕ) : ℕ := (Finset.filter (fun p => Nat.Prime p) (Finset.range n)).card
def fact (n : ℕ) : ℕ := ∏ i ∈ Finset.Icc 1 n, i
def multiples3or5 (n : ℕ) : ℕ := ∑ i ∈ Finset.filter (fun i => i % 3 = 0 ∨ i % 5 = 0) (Finset.range n), i
def IsPerfect (n : ℕ) : Prop := 0 < n ∧ ∑ d ∈ Finset.filter (fun d => d ∣ n) (Finset.Icc 1 n), d = n
