/- Hidden test battery for Level Spot the bug: the library. -/
import LeanCraftGame.Referee
import LeanCraftGame.L24.Player

namespace L28Ref
def CommonDivisor (d a b : ℕ) : Prop := a ∣ d ∧ b ∣ d
def TwinPrime (p : ℕ) : Prop := Nat.Prime p ∨ Nat.Prime (p + 2)
def multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}
end L28Ref

#no_sorry L24.cdD
#no_sorry L24.cdA
#no_sorry L24.cdB
#no_sorry L24.twin
#no_sorry L24.mulK
#no_sorry L24.mulN
#level_start "Spot the bug: the library"

#expect_true "CommonDivisor accepts your three numbers" unfolding L28Ref.CommonDivisor L24.cdD L24.cdA L24.cdB :
  L28Ref.CommonDivisor L24.cdD L24.cdA L24.cdB
#expect_true "cdD does not divide both cdA and cdB" unfolding L24.cdD L24.cdA L24.cdB :
  ¬ (L24.cdD ∣ L24.cdA ∧ L24.cdD ∣ L24.cdB)
#expect_true "TwinPrime accepts your number" unfolding L28Ref.TwinPrime L24.twin :
  L28Ref.TwinPrime L24.twin
#expect_true "your number and the number 2 above it are not both prime" unfolding L24.twin :
  ¬ (Nat.Prime L24.twin ∧ Nat.Prime (L24.twin + 2))
#expect_true "mulN ∈ multiplesOf mulK holds" unfolding L28Ref.multiplesOf L24.mulK L24.mulN :
  L24.mulN ∈ L28Ref.multiplesOf L24.mulK
#expect_true "mulN is not a multiple of mulK" unfolding L24.mulK L24.mulN :
  ¬ (L24.mulK ∣ L24.mulN)

#level_report
