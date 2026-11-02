-- some bound M is at least every |u n| (already done)
def BoundedSeq (u : ℕ → ℝ) : Prop := ∃ M, ∀ n, |u n| ≤ M

-- u converges to a: for every ε > 0, from some index N on,
-- every term u n is within ε of a
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
