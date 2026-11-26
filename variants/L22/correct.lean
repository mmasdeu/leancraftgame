def fac : ℕ → ℕ
  | 0 => 1
  | n + 1 => (n + 1) * fac n

def fib : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | n + 2 => fib n + fib (n + 1)

def sumTo : ℕ → ℕ
  | 0 => 0
  | n + 1 => sumTo n + (n + 1)

def collatz (n : ℕ) : ℕ := if n % 2 = 0 then n / 2 else 3 * n + 1

statement sum_id (n : ℕ) : ∑ i ∈ Finset.range (n + 1), i = n * (n + 1) / 2

statement fac_ge (n : ℕ) : 2 ^ (n - 1) ≤ Nat.factorial n
