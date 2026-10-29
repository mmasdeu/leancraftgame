namespace L10

-- every term is at least 10 (already done)
def AllBig (u : Nat → Nat) : Prop := ∀ n, 10 ≤ u n

-- every term is at most B
def AlwaysBelow (u : Nat → Nat) (B : Nat) : Prop := ∀ n, B ≤ u n

-- every term is even
def AllEven (u : Nat → Nat) : Prop := ∀ n, u n % 2 = 0

end L10
