namespace L1

def TendsToInfinity (u : Nat → Nat) : Prop :=
  ∀ M, ∃ N, ∀ n > N, M < u n

end L1
