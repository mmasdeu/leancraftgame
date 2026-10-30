def EventuallyEqual (u : ℕ → ℕ) (a : ℕ) : Prop :=
  ∃ N, ∀ n, N ≤ n → u n = a

def InfinitelyOften (u : ℕ → ℕ) (a : ℕ) : Prop :=
  ∀ N, ∃ n, N < n ∧ u n = a

def OnlyFinitelyOften (u : ℕ → ℕ) (a : ℕ) : Prop :=
  ¬ InfinitelyOften u a

def Recurrent (u : ℕ → ℕ) : Prop :=
  InfinitelyOften u (u 0)
