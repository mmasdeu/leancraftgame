def TwinPrime (p : ℕ) : Prop := p.Prime ∧ (p + 2).Prime

def PrimitiveTriple (a b c : ℕ) : Prop := a ^ 2 + b ^ 2 = c ^ 2 ∧ Nat.Coprime a b

def lcm' (a b : ℕ) : ℕ := a * b / Nat.gcd a b

statement prime_two_le {p : ℕ} (hp : p.Prime) : 3 ≤ p

statement coprime_dvd {k m n : ℕ} (H1 : Nat.Coprime k m) (H2 : k ∣ m * n) : k ∣ n
