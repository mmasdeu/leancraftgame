-- y is half of x (already done; note: no division)
def IsHalf (x y : ℚ) : Prop := 2 * y = x

-- the average of a and b                    (average 1 2 = 3/2)
def average (a b : ℚ) : ℚ := a + b / 2

-- y is a reciprocal of x: x · y = 1 (0 has no reciprocal)
def IsReciprocal (x y : ℚ) : Prop := x * y = 1

-- the line through (x₁, y₁) and (x₂, y₂) has slope m; a vertical line has no slope
def HasSlope (x₁ y₁ x₂ y₂ m : ℚ) : Prop := x₁ ≠ x₂ ∧ m * (x₂ - x₁) = y₂ - y₁
