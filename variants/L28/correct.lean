@[ext]
structure Point where
  x : ℝ
  y : ℝ
  z : ℝ

def origin : Point := { x := 0, y := 0, z := 0 }
def p123 : Point := ⟨1, 2, 3⟩
def Point.add (a b : Point) : Point := ⟨a.x + b.x, a.y + b.y, a.z + b.z⟩
def Point.smul (r : ℝ) (a : Point) : Point := ⟨r * a.x, r * a.y, r * a.z⟩

structure StandardTwoSimplex where
  x : ℝ
  y : ℝ
  z : ℝ
  x_nonneg : 0 ≤ x
  y_nonneg : 0 ≤ y
  z_nonneg : 0 ≤ z
  sum_eq : x + y + z = 1
