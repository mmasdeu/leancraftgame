def LeapYear (y : Nat) : Prop := y % 400 = 0 ∨ (y % 100 ≠ 0 ∧ y % 4 = 0)

def IsTriangle (a b c : Nat) : Prop := ¬ (b + c ≤ a ∨ a + c ≤ b ∨ a + b ≤ c)

def ExactlyOneEven (a b c : Nat) : Prop :=
  (a % 2 + b % 2 + c % 2 = 2)
