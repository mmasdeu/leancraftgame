namespace L18

-- from some index on, every term is at least 10 (already done)
def EventuallyBig (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, 10 ≤ u n

-- f is zero at some n other than 0
def HasPositiveRoot (f : ℕ → ℕ) : Prop := ∃ n, n > 0 → f n = 0

-- from some index on, every term is 0
def EventuallyZero (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, u n = 0

end L18
