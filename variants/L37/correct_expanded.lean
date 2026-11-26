open Polynomial

def I : Ideal ℤ := Ideal.span {-12}

def p : ℤ[X] := X ^ 2 - 5 * X + C 6

def inv3 : ZMod 7 := (3 : ZMod 7)⁻¹

statement crt : ∀ m n : ℕ, m.Coprime n → Nonempty (ZMod (m * n) ≃+* ZMod m × ZMod n)
