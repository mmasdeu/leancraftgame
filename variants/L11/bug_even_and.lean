namespace L11

-- from index 3 on, the terms are at least 10 (already done)
def BigAfter (u : Nat → Nat) : Prop := ∀ n, 3 ≤ n → 10 ≤ u n

-- from index 5 on, the terms are at least 3
def LateBig (u : Nat → Nat) : Prop := ∀ n, 5 ≤ n → 3 ≤ u n

-- if n is even then u n is even
def EvenToEven (u : Nat → Nat) : Prop := ∀ n, n % 2 = 0 ∧ u n % 2 = 0

end L11
