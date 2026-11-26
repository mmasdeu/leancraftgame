structure GaussInt where
  re : ℤ
  im : ℤ

def GaussInt.add (z w : GaussInt) : GaussInt := ⟨z.re + w.re, z.im + w.im⟩
def GaussInt.mul (z w : GaussInt) : GaussInt := ⟨z.re * w.re - z.im * w.im, z.re * w.im + z.im * w.re⟩
def GaussInt.conj (z : GaussInt) : GaussInt := ⟨z.re, -z.im⟩
def GaussInt.norm (z : GaussInt) : ℤ := z.re ^ 2 - z.im ^ 2
def z5 : GaussInt := ⟨2, 1⟩
def w13 : GaussInt := ⟨3, 2⟩
