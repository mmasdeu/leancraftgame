def square (x : ℝ) : ℝ := x ^ 2
def am (a b : ℝ) : ℝ := (a + b) / 2
def double : ℝ → ℝ := fun x ↦ 2 * x
def twelve : ℝ := double (double 3)
def halfNat (n : ℕ) : ℕ := n / 2 + n % 2
