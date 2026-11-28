-- Sam's code (don't edit)
structure GaussInt where
  re : ℤ
  im : ℤ

-- the product (a + bi)(c + di)
def GaussInt.mul (z w : GaussInt) : GaussInt :=
  ⟨z.re * w.re + z.im * w.im, z.re * w.im + z.im * w.re⟩

structure Point where
  x : ℚ
  y : ℚ
  z : ℚ

-- the midpoint of a and b
def Point.mid (a b : Point) : Point :=
  ⟨(a.x + b.x) / 2, (a.y + b.y) / 2, (a.z + a.z) / 2⟩

-- the rational numbers t with 0 ≤ t ≤ 1
structure UnitInterval where
  t : ℚ
  in_range : 0 ≤ t ∨ t ≤ 1

-- Your counterexamples
def gz : GaussInt := ⟨0, 1⟩
def gw : GaussInt := ⟨0, 1⟩
def pa : Point := ⟨0, 0, 0⟩
def pb : Point := ⟨0, 0, 2⟩
def badT : ℚ := 1 / 2
