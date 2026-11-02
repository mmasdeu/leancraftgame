def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
def seqA : ℕ → ℝ := fun _ => 0
def limA : ℝ := 0
def seqB : ℕ → ℝ := fun _ => 5
def limB : ℝ := 0
