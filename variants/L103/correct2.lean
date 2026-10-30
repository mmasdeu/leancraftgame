def absDiff (a b : ℕ) : ℕ := (a - b) + (b - a)

def signum (x : ℤ) : ℤ := if 0 < x then 1 else if x < 0 then -1 else 0

def ratio (a b : ℕ) : ℚ := if b = 0 then 0 else (a : ℚ) / (b : ℚ)

def percent (a b : ℕ) : ℕ := if b = 0 then 0 else (100 * a + b / 2) / b
