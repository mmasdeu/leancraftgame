structure GaussInt where
  re : ℤ
  im : ℤ

def GaussInt.add (z w : GaussInt) : GaussInt := { re := z.re + w.re, im := z.im + w.im }
def GaussInt.mul (z w : GaussInt) : GaussInt where
  re := z.re * w.re - z.im * w.im
  im := z.im * w.re + z.re * w.im
def GaussInt.conj (z : GaussInt) : GaussInt := ⟨z.re, 0 - z.im⟩
def GaussInt.norm (z : GaussInt) : ℤ := z.re * z.re + z.im * z.im
def z5 : GaussInt := ⟨-1, 2⟩
def w13 : GaussInt := ⟨2, -3⟩
