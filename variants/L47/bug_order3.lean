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
  | 0 => ⟨1, 0, 0, 1⟩
  | n + 1 => mul (pow M n) M

-- the Fibonacci matrix (1 1 / 1 0)
def fibMatrix : Matrix2 := ⟨1, 1, 1, 0⟩

-- the n-th Fibonacci number, read off the matrix fibMatrix ^ n (it is the entry b)
def fibM (n : ℕ) : ℤ := (pow fibMatrix n).b

-- a matrix of order exactly 6: R⁶ is the identity, and no smaller positive power is
def order6 : Matrix2 := ⟨0, -1, 1, -1⟩
