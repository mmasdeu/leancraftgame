def Periodic (u : ℕ → ℕ) : Prop := ∃ p > 0, ∀ n, u (n + p) = u n

def EventuallyConstant (u : ℕ → ℕ) : Prop := ∃ N c, ∀ n ≥ N, u n = c

def HasMaximum (u : ℕ → ℕ) : Prop := ∃ m, ∀ n, u m ≤ u n

def EventuallyPeriodic (u : ℕ → ℕ) : Prop := ∃ p > 0, ∃ N, ∀ n ≥ N, u (n + p) = u n
