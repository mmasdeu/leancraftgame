-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

def ClusterValue (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∀ N, ∃ n ≥ N, |u n - a| < ε

def IsSubseqLimit (u : ℕ → ℝ) (φ : ℕ → ℕ) (a : ℝ) : Prop := (∀ m n, m < n → φ m ≤ φ n) ∧ ConvergesTo (fun n => u (φ n)) a
