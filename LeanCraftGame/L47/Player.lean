/-
# Challenge: matrices

The Fibonacci recursion is linear, so it is a matrix power:

`(F(n+1) F(n) / F(n) F(n-1)) = (1 1 / 1 0)ⁿ`.

Two consequences, for free. Taking determinants gives **Cassini's
identity** `F(n+1)F(n-1) - F(n)² = (-1)ⁿ` (you checked it by brute force
in the Foundations world). And the power can be computed by repeated
squaring in `O(log n)` multiplications, which is how large Fibonacci
numbers are computed in practice.

Matrix powers are defined by recursion, like powers of numbers and of
Gaussian integers: `M⁰` is the identity and `Mⁿ⁺¹ = Mⁿ · M`.

**Torsion in `SL₂(ℤ)`**: an integer matrix of finite order has order
`1, 2, 3, 4` or `6`; the characteristic polynomial of a matrix of order
`6` is `x² - x + 1`, the sixth cyclotomic polynomial, so its trace is `1`
and its determinant `1`. Find one.

## Your task

Define `pow`, `fibMatrix`, `fibM`, and construct a matrix of order exactly
`6`.
-/

namespace L47

-- 2×2 integer matrices and their product (already done)
structure Matrix2 where
  a : ℤ
  b : ℤ
  c : ℤ
  d : ℤ

def mul (M N : Matrix2) : Matrix2 :=
  ⟨M.a * N.a + M.b * N.c, M.a * N.b + M.b * N.d, M.c * N.a + M.d * N.c, M.c * N.b + M.d * N.d⟩

def det (M : Matrix2) : ℤ := M.a * M.d - M.b * M.c

-- M multiplied by itself n times (M⁰ is the identity)
def pow (M : Matrix2) : ℕ → Matrix2
  | 0 => sorry
  | n + 1 => sorry

-- the Fibonacci matrix (1 1 / 1 0)
def fibMatrix : Matrix2 := sorry

-- the n-th Fibonacci number, read off the matrix fibMatrix ^ n (it is the entry b)
def fibM (n : ℕ) : ℤ := sorry

-- a matrix of order exactly 6: R⁶ is the identity, and no smaller positive power is
def order6 : Matrix2 := sorry

end L47
