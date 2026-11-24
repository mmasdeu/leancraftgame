-- a, b, c are the side lengths of a non-degenerate triangle (strict triangle inequalities)
def IsTriangle (a b c : Nat) : Prop := a < b + c ∧ b < a + c ∧ c < a + b

-- a, b, c are the sides of a right triangle, the hypotenuse being any of the three
def IsRight (a b c : Nat) : Prop :=
  0 < a ∧ 0 < b ∧ 0 < c ∧ (a ^ 2 + b ^ 2 = c ^ 2 ∨ a ^ 2 + c ^ 2 = b ^ 2 ∨ b ^ 2 + c ^ 2 = a ^ 2)

-- exactly one of a, b, c is even
def ExactlyOneEven (a b c : Nat) : Prop :=
  (a % 2 = 0 ∧ b % 2 = 1 ∧ c % 2 = 1) ∨ (a % 2 = 1 ∧ b % 2 = 0 ∧ c % 2 = 1) ∨
    (a % 2 = 1 ∧ b % 2 = 1 ∧ c % 2 = 0)
