/-
# Your first definitions

*Noor's file defined `am`. The library also needs `square`, and both will state AM-GM in
the next world. "Write them yourself," says Noor, "and mind the brackets. Sam's first `am`
was `a + b / 2`."*

## Functions

A definition with arguments is a function:

```lean
def cube (x : ℝ) : ℝ := x ^ 3
```

You can write the same function with `fun` (also `λ`) and the arrow `↦` (type `\mapsto`,
or write `=>`):

```lean
def cube' : ℝ → ℝ := fun x ↦ x ^ 3
```

`ℝ → ℝ` is the type of functions from reals to reals. A function of two arguments has type
`ℝ → ℝ → ℝ`: it takes one real and returns a function that waits for the second.

## Applying a function

You apply a function **without brackets**: `cube 2`, `max a b`. Brackets only group.
`cube (cube 2)` is the cube of `cube 2`. `cube cube 2` is an error, since it applies
`cube` to the function `cube`. And `cube 2 + 1` is `(cube 2) + 1`, because application
binds tighter than any operator.

## The type of a number

A numeral like `2` takes whatever type the context asks for. In `cube` above, everything is
real. When the context says nothing, the number is in `ℕ`, where division rounds down:
`7 / 2 = 3`. To get a real, write `(7 : ℝ) / 2`, which is `3.5`.

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

-- `double` applied twice to 3 (use `double`, don't compute by hand)
def twelve : ℝ := sorry

-- n halved in the natural numbers, rounding down
def halfNat (n : ℕ) : ℕ := sorry

end L2
