def BoundedAbove (u : ℕ → ℤ) : Prop :=
  ∀ n, ∃ M : ℕ, u n ≤ M

def Bounded (u : ℕ → ℤ) : Prop :=
  ∀ n, ∃ M : ℕ, |u n| ≤ M

def NonDecreasing (u : ℕ → ℤ) : Prop :=
  ∀ m n, m ≤ n → u m ≤ u n

def StrictlyIncreasing (u : ℕ → ℤ) : Prop :=
  ∀ m n, m < n → u m < u n
