namespace L28
def CommonDivisor (d a b : ℕ) : Prop := a ∣ d ∧ b ∣ d
def TwinPrime (p : ℕ) : Prop := Nat.Prime p ∨ Nat.Prime (p + 2)
def multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}
def cdD : ℕ := 1
def cdA : ℕ := 2
def cdB : ℕ := 3
def twin : ℕ := 7
def mulK : ℕ := 6
def mulN : ℕ := 3
end L28
