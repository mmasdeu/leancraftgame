/-
# Division by zero

What is `1 / 0`? On paper the question is not asked: `1/x` comes with the
side condition `x ≠ 0`. In Lean every function is total, so `1 / 0` must be
*something*, and Mathlib chose `0`. This is a **junk value**: harmless in
theorems (they carry the hypothesis `x ≠ 0` anyway, and `x / 0 = 0` makes
many identities hold without it), dangerous in definitions.

For example `IsReciprocal x y := y = 1 / x` looks right, and accepts `x = 0,
y = 0`. Its author meant "`x · y = 1`", which says the same thing for
`x ≠ 0` and correctly rules out `0`.

The general lesson: **a definition should state the property, not compute
it**. "Half of `x`" is `2y = x`, which needs no division at all. The slope of
the line through two points is the `m` with `m(x₂ - x₁) = y₂ - y₁`, *and*
the points must have different abscissas; otherwise every `m` (vertical
line) or no `m` would do.

We work in `ℚ`, where `1 / 2` is a genuine fraction.

## Your task

Define `average`, `IsReciprocal` and `HasSlope`.
-/

namespace L13

-- y is half of x (already done; note: no division)
def IsHalf (x y : ℚ) : Prop := 2 * y = x

-- the average of a and b                    (average 1 2 = 3/2)
def average (a b : ℚ) : ℚ := sorry

-- y is a reciprocal of x: x · y = 1 (0 has no reciprocal)
def IsReciprocal (x y : ℚ) : Prop := sorry

-- the line through (x₁, y₁) and (x₂, y₂) has slope m; a vertical line has no slope
def HasSlope (x₁ y₁ x₂ y₂ m : ℚ) : Prop := sorry

end L13
