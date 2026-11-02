-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

def ClusterValue (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∀ N, ∃ n, N ≤ n ∧ |u n - a| < ε

def IsSubseqLimit (u : ℕ → ℝ) (φ : ℕ → ℕ) (a : ℝ) : Prop := (∀ n, φ n < φ (n + 1)) ∧ ∀ ε > 0, ∃ N, ∀ n ≥ N, |u (φ n) - a| < ε
