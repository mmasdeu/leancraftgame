-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

def IsEventuallyConstant (u : ℕ → ℝ) : Prop := ∃ N, ∀ n ≥ N, u (n + 1) = u n

def IsCauchy (u : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ m ≥ N, ∀ n ≥ m, |u m - u n| < ε
