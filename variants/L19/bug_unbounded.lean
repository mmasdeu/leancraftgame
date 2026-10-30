def TendsToInfinity (u : Nat → Nat) : Prop :=
  ∀ M, ∃ n, M ≤ u n
