def TendsToInfinity (u : Nat → Nat) : Prop :=
  ∃ N, ∀ M, ∀ n ≥ N, M ≤ u n
