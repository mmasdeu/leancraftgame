def Periodic (u : ℕ → ℕ) : Prop := ∃ p > 0, ∀ n, u (n + p) = u n

def EventuallyConstant (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, u n = 0

def HasMaximum (u : ℕ → ℕ) : Prop := ∃ m, ∀ n, u n ≤ u m

def EventuallyPeriodic (u : ℕ → ℕ) : Prop := ∃ p > 0, ∃ N, ∀ n ≥ N, u (n + p) = u n
