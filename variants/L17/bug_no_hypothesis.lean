namespace L17

-- y is half of x (already done; note: no division)
def IsHalf (x y : ℚ) : Prop := 2 * y = x

-- the average of a and b                (average 1 2 is 3/2)
def average (a b : ℚ) : ℚ := (a + b) / 2

-- y is the reciprocal of x: x times y is 1.  (0 has no reciprocal!)
def IsReciprocal (x y : ℚ) : Prop := x * y = 1

-- the line through the points (x₁, y₁) and (x₂, y₂) has slope m.
-- A vertical line (x₁ = x₂) has no slope at all.
def HasSlope (x₁ y₁ x₂ y₂ m : ℚ) : Prop := m * (x₂ - x₁) = y₂ - y₁

end L17
