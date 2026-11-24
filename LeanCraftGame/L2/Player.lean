/-
# Functions

A function is a definition with an input:

```lean
def square (n : Nat) : Nat := n * n
```

`square` takes a natural number `n` and returns `n * n`. You apply it by
writing the input after the name, with a space: `square 7` is `49`, and
`square (2 + 1)` is `9`. No brackets around the argument are needed, only
around compound expressions.

## Division on ℕ

In `Nat` there are no fractions: `a / b` is the quotient of the Euclidean
division, rounded down. So `7 / 2 = 3`, and the order of operations
matters: `5 * 6 / 2 = 15`, but `5 / 2 * 6 = 12`. Gauss's formula
`n(n + 1)/2` is safe because the product `n(n + 1)` is always even, *as long
as you divide last*.

Likewise `a - b` is `0` when `b > a` ("truncated subtraction"): `3 - 5 = 0`.
This is a boundary case to keep in mind: `n - 1` is `0` when `n = 0`.

## Your task

Define `cube`, `triangular` and `handshakes`. The referee checks a few
values, and also identities such as `8·T(n) + 1 = (2n + 1)²` for every
`n ≤ 30`.
-/

namespace L2

-- n³
def cube (n : Nat) : Nat := sorry

-- the n-th triangular number 0 + 1 + ⋯ + n, by Gauss's formula n(n + 1)/2
def triangular (n : Nat) : Nat := sorry

-- the number of handshakes among n people, if each pair shakes hands once
def handshakes (n : Nat) : Nat := sorry

end L2
