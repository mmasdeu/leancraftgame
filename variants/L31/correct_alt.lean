structure GaussInt where
  re : ℤ
  im : ℤ

structure Point where
  x : ℚ
  y : ℚ
  z : ℚ

def gz : GaussInt := ⟨1, 2⟩
def gw : GaussInt := ⟨3, -1⟩
def pa : Point := ⟨0, 0, 0⟩
def pb : Point := ⟨1, 1, 1⟩
def badT : ℚ := -1
