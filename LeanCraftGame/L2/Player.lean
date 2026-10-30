/-
# Functions

A *function* turns an input into an output. To define one, name its input in
parentheses before the colon:

```lean
def double (n : Nat) : Nat := 2 * n
```

* `(n : Nat)` is the **input**: a natural number that we call `n`.
* The `Nat` after the colon is the type of the **output**.
* After `:=` comes a formula that may use `n`.

## Using a function

Write the function's name, a space, then the input: `double 5` is `10`.
There are **no brackets and no commas**. Brackets only group things:
`double (2 + 3)` is `10`, while `double 2 + 3` is `7`.

## Arithmetic

`+` add, `-` subtract, `*` multiply, `/` divide, `%` remainder.
Division on natural numbers drops the remainder: `7 / 2` is `3`, and
`7 % 2` is `1`.

**Careful:** natural numbers have no negatives. Subtraction stops at zero, so
`3 - 5` is `0`, not `-2`.

## Your task

Define the four functions below. The comment above each one gives examples.
-/
namespace L2

-- twice the input        (double 4 is 8)
def double (n : Nat) : Nat := sorry

-- the input times itself  (squared 5 is 25)
def squared (n : Nat) : Nat := sorry

-- ten more than the input (addTen 1 is 11)
def addTen (n : Nat) : Nat := sorry

-- one less than the input, but 0 stays 0   (minusOne 5 is 4, minusOne 0 is 0)
def minusOne (n : Nat) : Nat := sorry

end L2
