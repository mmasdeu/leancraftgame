def EventuallyEqual (u : ℕ → ℕ) (a : ℕ) : Prop :=
  ∃ N, ∀ n ≥ N, u n = u N

def InfinitelyOften (u : ℕ → ℕ) (a : ℕ) : Prop :=
  ∀ N, ∃ n ≥ N, u n = a

def OnlyFinitelyOften (u : ℕ → ℕ) (a : ℕ) : Prop :=
  ∃ N, ∀ n ≥ N, u n ≠ a

def Recurrent (u : ℕ → ℕ) : Prop :=
  ∀ N, ∃ n ≥ N, u n = u 0
