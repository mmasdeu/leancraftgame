def TendsToInfinity (u : Nat → Nat) : Prop :=
  ∀ M, ∃ N, ∀ n, N ≤ n → M ≤ u n
