structure GaussInt where
  re : ℤ
  im : ℤ

structure Point where
  x : ℚ
  y : ℚ
  z : ℚ

def gz : GaussInt := ⟨0, 1⟩
def gw : GaussInt := ⟨0, 1⟩
def pa : Point := ⟨0, 0, 0⟩
def pb : Point := ⟨0, 0, 2⟩
def badT : ℚ := 2
