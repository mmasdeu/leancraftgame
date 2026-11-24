-- |a - b| for natural numbers
def absDiff (a b : ℕ) : ℕ := if a ≤ b then b - a else a - b

-- the sign of x: -1, 0 or 1
def signum (x : ℤ) : ℤ := if x < 0 then -1 else if x = 0 then 0 else 1

-- a / b as an exact fraction (and 0 when b = 0, like Mathlib)
def ratio (a b : ℕ) : ℚ := (a : ℚ) / (b : ℚ)

-- x is the Egyptian fraction 1/a + 1/b with positive a and b
def IsEgyptian (x : ℚ) (a b : ℕ) : Prop := a ≠ 0 ∧ b ≠ 0 ∧ x = (a : ℚ)⁻¹ + (b : ℚ)⁻¹
