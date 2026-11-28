open Polynomial

def I : Ideal ℤ := Ideal.span {12}

def p : ℤ[X] := (2 - X) * (X - 3)

def inv3 : ZMod 7 := 5

statement crt (m n : ℕ) (h : Nat.Coprime m n) : Nonempty (ZMod (m * n) ≃+* ZMod m × ZMod n)
