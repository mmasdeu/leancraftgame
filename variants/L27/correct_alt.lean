structure Point where
  x : ℝ
  y : ℝ
  z : ℝ

def origin : Point := ⟨0, 0, 0⟩
def p123 : Point := Point.mk 1 2 3
def Point.add (a b : Point) : Point where
  x := a.x + b.x
  y := a.y + b.y
  z := a.z + b.z
def Point.smul (r : ℝ) (a : Point) : Point := { x := a.x * r, y := a.y * r, z := a.z * r }

structure StandardTwoSimplex where
  x : ℝ
  y : ℝ
  z : ℝ
  x_nonneg : x ≥ 0
  y_nonneg : y ≥ 0
  z_nonneg : z ≥ 0
  sum_eq : 1 = x + y + z
