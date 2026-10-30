def Periodic (u : ℕ → ℕ) : Prop := ∃ p, 0 < p ∧ ∀ n, u (n + p) = u n

def EventuallyConstant (u : ℕ → ℕ) : Prop := ∃ N, ∃ c, ∀ n, N ≤ n → u n = c

def HasMaximum (u : ℕ → ℕ) : Prop := ∃ m, ∀ n, u n ≤ u m

def EventuallyPeriodic (u : ℕ → ℕ) : Prop := ∃ N, ∃ p > 0, ∀ n ≥ N, u (n + p) = u n
