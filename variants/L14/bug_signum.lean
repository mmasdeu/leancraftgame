def absDiff (a b : ℕ) : ℕ := if a ≤ b then b - a else a - b

def signum (x : ℤ) : ℤ := if x < 0 then -1 else 1

def ratio (a b : ℕ) : ℚ := (a : ℚ) / b

def percent (a b : ℕ) : ℕ := (200 * a + b) / (2 * b)
