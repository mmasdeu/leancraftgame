namespace L1

def TendsToInfinity (u : Nat → Nat) : Prop :=
  ∀ M, ∃ n, M ≤ u n

end L1
