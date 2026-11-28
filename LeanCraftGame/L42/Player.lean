/-
# Matrices, bases and dimension

*The project ends by turning linear maps into arrays of numbers. Noor wants the quarter
turn of level 39 as a matrix, and the Fibonacci numbers of level 22 as entries of a matrix
power.*

## Matrices

`Matrix (Fin 2) (Fin 2) ℚ` is the type of 2 × 2 rational matrices. A matrix is a function
of two indices: `M i j` is the entry in **row `i`, column `j`**, both counted from 0. The
notation lists the rows, separated by `;`:

```lean
def M : Matrix (Fin 2) (Fin 2) ℚ := !![5, 6;
                                       7, 8]
-- M 1 0 = 7  (row 1, column 0)
```

* `A * B` is the product, `A ^ n` a power, and `1` the identity matrix.
* `A.mulVec v` (or `A *ᵥ v`) multiplies `A` by the column vector `v : Fin 2 → ℚ`.
* `A.det` (or `Matrix.det A`) is the determinant. For `!![a, b; c, d]` it's `a * d - b * c`.
* As a linear map `v ↦ A *ᵥ v`, column `j` of `A` is the image of the `j`-th basis
  vector.

## Bases and dimension

`Module.finrank K V` is the dimension of `V`, a natural number (`0`, a junk value, when
`V` is infinite-dimensional). The plane `Fin 2 → ℚ` has dimension 2.

## Fibonacci numbers

The matrix `!![1, 1; 1, 0]` turns a pair of consecutive Fibonacci numbers into the next
pair. For `n ≥ 1`, its powers are `!![F (n+1), F n; F n, F (n-1)]`.

## Your task

1. `rotM`: the matrix of the counterclockwise quarter turn. It sends `![1, 0]` to
   `![0, 1]` and `![0, 1]` to `![-1, 0]`.
2. `fibM`: the Fibonacci matrix, and `fib n`: the entry in row 0, column 1 of `fibM ^ n`,
   the `n`-th Fibonacci number `F n` (with `F 0 = 0`, `F 1 = 1`). This `fib` returns
   integers.
3. `singular`: a matrix with no zero entry and determinant `0`.
4. `detB`: the determinant of `!![2, 1; 7, 4]`, written as a number you compute.
-/
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace L42

def rotM : Matrix (Fin 2) (Fin 2) ℚ := sorry

def fibM : Matrix (Fin 2) (Fin 2) ℤ := sorry

def fib (n : ℕ) : ℤ := sorry

def singular : Matrix (Fin 2) (Fin 2) ℚ := sorry

def detB : ℚ := sorry

end L42
