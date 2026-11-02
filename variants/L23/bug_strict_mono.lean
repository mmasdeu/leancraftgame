def TendsToInfinity (u : Nat → Nat) : Prop :=
  ∀ n, u n < u (n + 1)
