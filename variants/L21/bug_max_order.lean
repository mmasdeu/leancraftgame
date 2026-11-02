def Periodic (u : ℕ → ℕ) : Prop := ∃ p > 0, ∀ n, u (n + p) = u n

def EventuallyConstant (u : ℕ → ℕ) : Prop := ∃ N c, ∀ n ≥ N, u n = c

def HasMaximum (u : ℕ → ℕ) : Prop := ∀ n, ∃ m, u n ≤ u m

def EventuallyPeriodic (u : ℕ → ℕ) : Prop := ∃ p > 0, ∃ N, ∀ n ≥ N, u (n + p) = u n
