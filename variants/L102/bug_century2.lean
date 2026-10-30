def LeapYear (y : Nat) : Prop := y % 4 = 0 ∧ y % 100 ≠ 0

def IsTriangle (a b c : Nat) : Prop := a < b + c ∧ b < a + c ∧ c < a + b

def ExactlyOneEven (a b c : Nat) : Prop :=
  (a % 2 = 0 ∧ b % 2 ≠ 0 ∧ c % 2 ≠ 0) ∨
  (a % 2 ≠ 0 ∧ b % 2 = 0 ∧ c % 2 ≠ 0) ∨
  (a % 2 ≠ 0 ∧ b % 2 ≠ 0 ∧ c % 2 = 0)
