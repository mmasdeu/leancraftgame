namespace L27
def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n
def good₁ : ℕ → ℕ := fun n => n
def good₂ : ℕ → ℕ := fun n => 2 * n
def bad₁ : ℕ → ℕ := fun _ => 0
def bad₂ : ℕ → ℕ := fun n => n % 2
end L27
