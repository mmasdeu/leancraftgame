-- the right definition (already done)
def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n

-- two sequences that tend to infinity
def good₁ : ℕ → ℕ := fun n => if n % 2 = 0 then 2 * n else n
def good₂ : ℕ → ℕ := fun n => n / 2

-- two sequences that do not
def bad₁ : ℕ → ℕ := fun n => n % 2 * n
def bad₂ : ℕ → ℕ := fun n => min n 3
