-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

def IsEventuallyConstant (u : ℕ → ℝ) : Prop := ∃ N, ∀ n ≥ N, u n = u N

def IsCauchy (u : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ m ≥ N, ∀ n ≥ N, |u m - u n| < ε
