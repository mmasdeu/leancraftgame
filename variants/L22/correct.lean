def HasPositiveRoot (f : ℕ → ℕ) : Prop := ∃ n, n > 0 → f n = 0
def EventuallyZero (u : ℕ → ℕ) : Prop := ∀ N, ∃ n ≥ N, u n = 0
def Unbounded (u : ℕ → ℕ) : Prop := ∃ M, ∀ n, M ≤ u n
def noRoot : ℕ → ℕ := fun n => n + 1
def notEventuallyZero : ℕ → ℕ := fun n => n % 2
def bounded : ℕ → ℕ := fun _ => 7
