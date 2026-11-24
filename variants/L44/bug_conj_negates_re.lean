-- a point of the plane with integer coordinates (already done)
structure Point where
  x : ℤ
  y : ℤ

-- a Gaussian integer a + b·i: two integer fields `re` and `im`, in this order
structure GaussInt where
  re : ℤ
  im : ℤ

-- the imaginary unit i = 0 + 1·i
def I : GaussInt := ⟨0, 1⟩

-- 3 + 4i
def z34 : GaussInt := ⟨3, 4⟩

-- the norm a² + b² of a + b·i
def normSq (z : GaussInt) : ℤ := z.re ^ 2 + z.im ^ 2

-- the conjugate a - b·i of a + b·i
def conjugate (z : GaussInt) : GaussInt := ⟨-z.re, z.im⟩

-- the point (a, b) of the plane
def toPoint (z : GaussInt) : Point := ⟨z.re, z.im⟩
