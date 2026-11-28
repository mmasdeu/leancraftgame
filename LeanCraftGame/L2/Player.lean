/-
# Your first definitions

*The library needs `am` and `square` to state AM-GM in the next world. "Write them
yourself," says Noor, "and mind the brackets. Sam's first `am` was `a + b / 2`."*

## Functions

A definition with arguments is a function:

```lean
def cube (x : ℝ) : ℝ := x ^ 3
```

`x ^ n` is the `n`-th power of `x`.

You can write the same function with `fun` (also `λ`) and the arrow `↦` (type `\mapsto`,
or write `=>`):

```lean
def cube' : ℝ → ℝ := fun x ↦ x ^ 3
```

`ℝ → ℝ` is the type of functions from reals to reals. A function of two reals has type
`ℝ → ℝ → ℝ`: it takes one real and returns a function waiting for the second.

## Applying a function

You apply a function **without brackets**: `cube 2`, `max a b`. Brackets only group:
`cube (cube 2)` works, while `cube cube 2` is an error (it applies `cube` to the function
`cube`). Application binds tighter than any operator, so `cube 2 + 1` is `(cube 2) + 1`.

## The type of a number

A numeral like `2` takes the type its surroundings ask for: in `x / 2` with `x : ℝ`, the
`2` is a real. With nothing around it, it's in `ℕ`, where division rounds down:
`5 / 2 = 2`. For a real, write `(5 : ℝ) / 2`, which is `2.5`.

## Your task

Replace each `sorry` with a definition. Each comment says what the value should be.
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
