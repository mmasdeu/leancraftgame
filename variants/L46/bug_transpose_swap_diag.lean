-- a 2×2 integer matrix (a b / c d); every field has a default: the identity matrix
structure Matrix2 where
  a : ℤ := 1
  b : ℤ := 0
  c : ℤ := 0
  d : ℤ := 1

-- the identity matrix, written with the defaults only: `{}`
def identity : Matrix2 := {}

-- the shear (1 k / 0 1): the identity with b changed, written `{ b := k }`
def shear (k : ℤ) : Matrix2 := { b := k }

-- the transpose: M with b and c exchanged, written `{ M with … }`
def transpose (M : Matrix2) : Matrix2 := { M with a := M.d, d := M.a }

-- the determinant ad - bc
def det (M : Matrix2) : ℤ := M.a * M.d - M.b * M.c

-- the product of two matrices (rows of M times columns of N)
def mul (M N : Matrix2) : Matrix2 :=
  ⟨M.a * N.a + M.b * N.c, M.a * N.b + M.b * N.d, M.c * N.a + M.d * N.c, M.c * N.b + M.d * N.d⟩
