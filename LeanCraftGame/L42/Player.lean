/-
# Matrices, bases and dimension

MIL §10.4 connects linear maps with the arrays of numbers that represent them.

## Matrices

`Matrix (Fin 2) (Fin 2) ℚ` is the type of 2 × 2 matrices with rational entries. A
matrix is a function of two indices, so `M i j` is the entry in **row `i`, column `j`**,
both counted **from 0**. Mathlib's notation lists the rows, separated by `;`:

```lean
def A : Matrix (Fin 2) (Fin 2) ℚ := !![1, 2;
                                       3, 4]
-- A 0 1 = 2  (row 0, column 1)        A 1 0 = 3
```

* `A * B` is the matrix product and `A ^ n` a power; `1` is the identity matrix.
* `A.mulVec v` (or `A *ᵥ v`) multiplies `A` by the column vector `v : Fin 2 → ℚ`.
* `A.det` (or `Matrix.det A`) is the determinant: for `!![a, b; c, d]` it is `a * d - b * c`.
* `Matrix.toLin' A : (Fin 2 → ℚ) →ₗ[ℚ] (Fin 2 → ℚ)` is the linear map `v ↦ A *ᵥ v`.
  Column `j` of `A` is the image of the `j`-th basis vector.

## Bases and dimension

```lean
variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]
#check (Basis ι K V)            -- a basis of V indexed by ι
#check Module.finrank K V       -- the dimension of V, a natural number
```

A `Basis ι K V` is again a structure: an equivalence between `V` and the finitely
supported functions `ι →₀ K`, the coordinates. `Module.finrank K V` is the dimension when
`V` is finite-dimensional, and `0` otherwise (a junk value, like `x / 0 = 0`).

## Fibonacci numbers

The matrix `!![1, 1; 1, 0]` turns a pair of consecutive Fibonacci numbers into the next
pair. Its powers are `!![F (n+1), F n; F n, F (n-1)]`: the Fibonacci numbers appear as
entries.

## Your task

1. `rotM`: the matrix of the quarter turn of the plane (counterclockwise): it sends
   `![1, 0]` to `![0, 1]` and `![0, 1]` to `![-1, 0]`.
2. `fibM`: the Fibonacci matrix, and `fib n`: the entry of `fibM ^ n` that is the
   `n`-th Fibonacci number `F n` (with `F 0 = 0`, `F 1 = 1`).
3. `singular`: a matrix with no zero entry and determinant `0`.
4. `detB`: the determinant of `!![2, 1; 7, 4]`, as a number you compute.
-/
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace L42

def rotM : Matrix (Fin 2) (Fin 2) ℚ := sorry

def fibM : Matrix (Fin 2) (Fin 2) ℤ := sorry

def fib (n : ℕ) : ℤ := sorry

def singular : Matrix (Fin 2) (Fin 2) ℚ := sorry

def detB : ℚ := sorry

end L42
