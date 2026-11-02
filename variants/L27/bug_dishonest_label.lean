def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n
def good₁ : ℕ → ℕ := fun n => n / 2
def good₂ : ℕ → ℕ := fun n => n + 3 * (n % 2)
-- "bad", but it does tend to infinity
def bad₁ : ℕ → ℕ := fun n => n
def bad₂ : ℕ → ℕ := fun _ => 7
