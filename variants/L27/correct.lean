namespace L27
def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n
def good₁ : ℕ → ℕ := fun n => n / 2
def good₂ : ℕ → ℕ := fun n => n + 3 * (n % 2)
def bad₁ : ℕ → ℕ := fun n => if n % 2 = 0 then n else 0
def bad₂ : ℕ → ℕ := fun _ => 7
end L27
