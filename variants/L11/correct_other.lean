-- A colleague's definitions (to read: the referee uses its own copy).
def InRange (n : Nat) : Prop := 13 ≤ n ∨ n ≤ 19              -- meant: 13 ≤ n ≤ 19
def IsComposite (n : Nat) : Prop := ¬ Nat.Prime n               -- meant: composite
def Coprime (a b : Nat) : Prop := ¬ (2 ∣ a ∧ 2 ∣ b)            -- meant: gcd a b = 1
def BothOdd (a b : Nat) : Prop := ¬ a % 2 = 0 ∧ b % 2 = 0      -- meant: a and b odd

-- accepted by InRange, but not between 13 and 19
def r : Nat := 5
-- accepted by IsComposite, but not composite
def c : Nat := 0
-- accepted by Coprime, but with a common factor
def ca : Nat := 9
def cb : Nat := 15
-- two odd numbers that BothOdd rejects
def oa : Nat := 7
def ob : Nat := 7
