-- a - b as an integer, for natural numbers a and b      (diff 3 5 = -2)
def diff (a b : ℕ) : ℤ := ↑a - ↑b

-- the distance |a - b| between two integers, as a natural number   (gap 3 (-4) = 7)
def gap (a b : ℤ) : ℕ := if a ≤ b then (b - a).toNat else (a - b).toNat

-- x is an odd integer (positive or negative)
def IsOddInt (x : ℤ) : Prop := ¬ 2 ∣ x
