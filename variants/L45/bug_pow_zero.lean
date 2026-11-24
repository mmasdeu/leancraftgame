-- the Gaussian integers (already done)
structure GaussInt where
  re : ℤ
  im : ℤ

def GaussInt.normSq (z : GaussInt) : ℤ := z.re ^ 2 + z.im ^ 2

-- (a + bi) + (c + di)
def GaussInt.add (z w : GaussInt) : GaussInt := ⟨z.re + w.re, z.im + w.im⟩

-- (a + bi)(c + di) = (ac - bd) + (ad + bc)i
def GaussInt.mul (z w : GaussInt) : GaussInt :=
  ⟨z.re * w.re - z.im * w.im, z.re * w.im + z.im * w.re⟩

-- z multiplied by itself n times (z⁰ = 1)
def GaussInt.pow (z : GaussInt) : ℕ → GaussInt
  | 0 => ⟨0, 0⟩
  | n + 1 => (z.pow n).mul z
