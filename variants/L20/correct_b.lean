def TwinPrime (p : ℕ) : Prop := Nat.Prime p ∧ Nat.Prime (p + 2)

def PrimitiveTriple (a b c : ℕ) : Prop := Nat.gcd a b = 1 ∧ a * a + b * b = c * c

def lcm' (a b : ℕ) : ℕ := a / Nat.gcd a b * b

statement prime_two_le : ∀ p : ℕ, Nat.Prime p → p ≥ 2

statement coprime_dvd (k m n : ℕ) : Nat.Coprime k m → k ∣ m * n → k ∣ n
