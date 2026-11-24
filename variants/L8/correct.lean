-- p and 2p + 1 are both prime (Sophie Germain)
def IsSophieGermain (p : Nat) : Prop := Nat.Prime p ∧ Nat.Prime (2 * p + 1)

-- p and p + 2 are both prime
def IsTwinPrime (p : Nat) : Prop := Nat.Prime p ∧ Nat.Prime (p + 2)

-- n > 1 and n is not prime
def IsComposite (n : Nat) : Prop := 1 < n ∧ ¬ Nat.Prime n

-- n is divisible by 2 or by 3, but not by both
def ExactlyOneOf23 (n : Nat) : Prop := (2 ∣ n ∨ 3 ∣ n) ∧ ¬ (2 ∣ n ∧ 3 ∣ n)
