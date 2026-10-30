def BoundedAbove (u : ℕ → ℤ) : Prop :=
  ∃ M : ℕ, ∀ n, u n ≤ M

def Bounded (u : ℕ → ℤ) : Prop :=
  ∃ M : ℕ, ∀ n, -M ≤ u n ∧ u n ≤ M

def NonDecreasing (u : ℕ → ℤ) : Prop :=
  ∀ n, u n ≤ u (n + 1)

def StrictlyIncreasing (u : ℕ → ℤ) : Prop :=
  ∀ n, u n < u (n + 1)
