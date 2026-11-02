def evenSet (n : ℕ) : Finset ℕ := Finset.filter (fun i => i % 2 = 0) (Finset.range n)
def sumOdds (n : ℕ) : ℕ := ∑ i ∈ Finset.filter (fun i => i % 2 = 1) (Finset.range n), i
def numDivisors (n : ℕ) : ℕ := (Finset.filter (· ∣ n) (Finset.range (n + 1))).card - (if n = 0 then 1 else 0)
def countPrimes (n : ℕ) : ℕ := (Finset.filter Nat.Prime (Finset.Ico 0 n)).card
def fact (n : ℕ) : ℕ := ∏ i ∈ Finset.range n, (i + 1)
def multiples3or5 (n : ℕ) : ℕ := ∑ i ∈ Finset.range n, if i % 3 = 0 ∨ i % 5 = 0 then i else 0
def IsPerfect (n : ℕ) : Prop := 0 < n ∧ ∑ d ∈ Finset.filter (fun d => d ∣ n) (Finset.Icc 1 n), d = 2 * n
