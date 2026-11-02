def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
def seqA : ℕ → ℝ := fun _ => 0
def limA : ℝ := 1
def seqB : ℕ → ℝ := fun n => if n % 2 = 0 then 0 else 1
def limB : ℝ := 0
