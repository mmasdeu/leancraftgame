/- Hidden test battery for Level 2. -/
import DefGame.Referee
import DefGame.L2.Player

open L2

/-! A non-commutative group: S₃ ≅ ℤ/3 ⋊ ℤ/2, encoded on `Fin 6` as `a + 3s`. -/
def S3.mul (x y : Fin 6) : Fin 6 :=
  let a := x.val % 3; let s := x.val / 3; let b := y.val % 3; let t := y.val / 3
  Fin.ofNat 6 ((a + (if s = 0 then b else 3 - b)) % 3 + 3 * ((s + t) % 2))
def S3.inv (x : Fin 6) : Fin 6 :=
  let a := x.val % 3; let s := x.val / 3
  Fin.ofNat 6 ((if s = 0 then (3 - a) % 3 else a) + 3 * s)

#level_start "Level 2 · A colleague's groups"

/-! ### Part A: your junk model -/
#expect_model "Part A: your junk model satisfies the colleague's axioms" :
  Group'.mk junkMul junkOne junkInv
#expect_true "Part A: …and yet it is not a group" :
  (∃ a, junkMul a junkOne ≠ a) ∨ (∃ a, junkMul (junkInv a) a ≠ junkOne)

/-! ### Part B: real groups must be models -/
#expect_model "Part B: (ℤ, +) is a group" :
  Group₂.mk (G := Int) (· + ·) 0 (- ·)
#expect_model "Part B: (Bool, xor) is a group" :
  Group₂.mk (G := Bool) xor false id
#expect_model "Part B: ℤ/3 is a group" :
  Group₂.mk (G := Fin 3) (· + ·) 0 (- ·)
#expect_model "Part B: S₃ (non-commutative!) is a group" :
  Group₂.mk (G := Fin 6) S3.mul 0 S3.inv

/-! ### Part B: junk models must be ruled out -/
#expect_not_model "Part B: 'a * b = b' on Bool is not a group" :
  Group₂.mk (G := Bool) (fun _ b => b) false (fun _ => false)
#expect_not_model "Part B: 'a * b = b' on ℤ/3 is not a group" :
  Group₂.mk (G := Fin 3) (fun _ b => b) 0 (fun _ => 0)
#expect_not_model "Part B: 'a * b = b' on ℤ is not a group" :
  Group₂.mk (G := Int) (fun _ b => b) 0 (fun _ => 0)
#expect_not_model "Part B: (ℕ, +) is not a group" :
  Group₂.mk (G := Nat) (· + ·) 0 id
#expect_not_model "Part B: (Bool, and) is not a group" :
  Group₂.mk (G := Bool) and true id

#level_report
