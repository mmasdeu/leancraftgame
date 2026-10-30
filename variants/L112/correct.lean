-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

def Diverges (u : ℕ → ℝ) : Prop := ¬ ∃ a, ConvergesTo u a

def ClusterValue (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∀ N, ∃ n ≥ N, |u n - a| < ε
