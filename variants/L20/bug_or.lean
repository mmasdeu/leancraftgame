namespace L20

-- n is even and at least 4 (already done)
def BigEven (n : ℕ) : Prop := Even n ∧ 4 ≤ n

-- p and p + 2 are both prime          (TwinPrime 5 is true: 5 and 7)
def TwinPrime (p : ℕ) : Prop := Nat.Prime p ∨ Nat.Prime (p + 2)

-- d divides both a and b              (CommonDivisor 3 6 9 is true)
def CommonDivisor (d a b : ℕ) : Prop := d ∣ a ∧ d ∣ b

-- f never takes the same value twice (use Mathlib's name for this)
def OneToOne (f : ℕ → ℕ) : Prop := Function.Injective f

end L20
