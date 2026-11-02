-- some term is at least 10 (already done)
def HasBig (u : Nat → Nat) : Prop := ∃ n, 10 ≤ u n

-- some term is zero
def HasZero (u : Nat → Nat) : Prop := ∃ n, u n = 0

-- some single term is both even and at least 10
def HasEvenBig (u : Nat → Nat) : Prop := (∃ n, u n % 2 = 0) ∧ (∃ n, 10 ≤ u n)
