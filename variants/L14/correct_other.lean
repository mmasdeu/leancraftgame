def ConvergesTo0 (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n| < ε
def good₁ : ℕ → ℝ := fun n => if n < 3 then -2 else 0
def good₂ : ℕ → ℝ := fun n => if n = 2 then 3 else 0
def bad₁ : ℕ → ℝ := fun n => if n % 2 = 0 then 0 else 2
def bad₂ : ℕ → ℝ := fun _ => -1/2
