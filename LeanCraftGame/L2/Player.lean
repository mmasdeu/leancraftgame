/-
# Your first definitions

*Noor's file defined `am`; the library also needs `square`, and both will be used to
state AM-GM in the next world. "Write them yourself," says Noor, "and mind the
brackets: Sam's first `am` was `a + b / 2`."*

## Functions

A definition with arguments is a function:

```lean
def cube (x : ℝ) : ℝ := x ^ 3
```

The same function can be written with `fun` (also spelled `λ`), and the arrow `↦` (type
`\mapsto`, or write `=>`):

```lean
def cube' : ℝ → ℝ := fun x ↦ x ^ 3
```

`ℝ → ℝ` is the type of functions from reals to reals. A function of two arguments has
type `ℝ → ℝ → ℝ`: it takes one real and returns a function that waits for the second.

## Applying a function

Application is written **without brackets**: `cube 2`, `max a b`. Brackets only group:
`cube (cube 2)` is the cube of `cube 2`, while `cube cube 2` is an error (it applies
`cube` to the function `cube`). And `cube 2 + 1` is `(cube 2) + 1`: application binds
tighter than any operator.

## The type of a number

A numeral such as `2` has no type of its own: Lean gives it the type the context asks
for. In `def cube (x : ℝ) : ℝ := x ^ 3` everything is real. When the context says
nothing, the number is a natural number in `ℕ`, where division rounds down: `7 / 2 = 3`.
To force a real, write `(7 : ℝ) / 2`, which is `3.5`.

## Your task

Fill in the five definitions. Each comment says what the value should be.
-/
namespace L2

-- the square of x
def square (x : ℝ) : ℝ := sorry

-- the arithmetic mean of a and b, the right-hand side of AM-GM
def am (a b : ℝ) : ℝ := sorry

-- the function x ↦ 2x, written with `fun`
def double : ℝ → ℝ := sorry

-- `double` applied twice to 3 (use `double`, do not compute by hand)
def twelve : ℝ := sorry

-- n halved, in the natural numbers (rounding down)
def halfNat (n : ℕ) : ℕ := sorry

end L2
