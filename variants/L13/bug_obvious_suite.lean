def ConvergesTo0 (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n| < ε
def good₁ : ℕ → ℝ := fun _ => 0
def good₂ : ℕ → ℝ := fun _ => 0
def bad₁ : ℕ → ℝ := fun n => n
def bad₂ : ℕ → ℝ := fun _ => 5
