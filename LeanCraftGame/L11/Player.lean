/-
# Division by zero

The rationals `ℚ` (type `\Q`) are the fractions: `(1 / 2 : ℚ)` is one half.

In Lean every function is defined on **all** its inputs, so `x / 0` has to be
*something*. Mathlib chooses `0`:

```lean
example : (1 : ℚ) / 0 = 0 := by simp     -- a theorem!
```

You have already met such *junk values*: `(3 : ℕ) - 5 = 0`, `(7 : ℕ) / 0 = 0`,
`(-3 : ℤ).toNat = 0`. Mathlib has more: `Real.sqrt (-1) = 0`, `(0 : ℚ)⁻¹ = 0`.
They are convenient for writing proofs, but a definition that divides can be
**silently wrong** at zero.

## The cure

State definitions without dividing, or add the hypothesis you need:

```lean
-- "y is half of x"
def IsHalf (x y : ℚ) : Prop := 2 * y = x       -- multiply instead of dividing
```

Dividing by a number that cannot be zero, like `2`, is perfectly fine.

Remember the binding strengths: `a + b / 2` is `a + (b / 2)`.

## Your task

`IsHalf` is done. Define `average`, `IsReciprocal` and `HasSlope`. The tests
include the cases where a division by zero would hide.
-/
namespace L11

-- y is half of x (already done; note: no division)
def IsHalf (x y : ℚ) : Prop := 2 * y = x

-- the average of a and b                (average 1 2 is 3/2)
def average (a b : ℚ) : ℚ := sorry

-- y is the reciprocal of x: x times y is 1.  (0 has no reciprocal!)
def IsReciprocal (x y : ℚ) : Prop := sorry

-- the line through the points (x₁, y₁) and (x₂, y₂) has slope m.
-- A vertical line (x₁ = x₂) has no slope at all.
def HasSlope (x₁ y₁ x₂ y₂ m : ℚ) : Prop := sorry

end L11
