/- Hidden test battery for Level Spot the bug: the library. -/
import LeanCraftGame.Referee
import LeanCraftGame.L33.Player

namespace L33Ref
def CommonDivisor (d a b : ℕ) : Prop := a ∣ d ∧ b ∣ d
def TwinPrime (p : ℕ) : Prop := Nat.Prime p ∨ Nat.Prime (p + 2)
def multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}
end L33Ref

#no_sorry L33.cdD
#no_sorry L33.cdA
#no_sorry L33.cdB
#no_sorry L33.twin
#no_sorry L33.mulK
#no_sorry L33.mulN
#level_start "Spot the bug: the library"

#expect_true "CommonDivisor accepts your three numbers" unfolding L33Ref.CommonDivisor L33.cdD L33.cdA L33.cdB :
  L33Ref.CommonDivisor L33.cdD L33.cdA L33.cdB
#expect_true "cdD does not divide both cdA and cdB" unfolding L33.cdD L33.cdA L33.cdB :
  ¬ (L33.cdD ∣ L33.cdA ∧ L33.cdD ∣ L33.cdB)
#expect_true "TwinPrime accepts your number" unfolding L33Ref.TwinPrime L33.twin :
  L33Ref.TwinPrime L33.twin
#expect_true "your number and the number 2 above it are not both prime" unfolding L33.twin :
  ¬ (Nat.Prime L33.twin ∧ Nat.Prime (L33.twin + 2))
#expect_true "mulN ∈ multiplesOf mulK holds" unfolding L33Ref.multiplesOf L33.mulK L33.mulN :
  L33.mulN ∈ L33Ref.multiplesOf L33.mulK
#expect_true "mulN is not a multiple of mulK" unfolding L33.mulK L33.mulN :
  ¬ (L33.mulK ∣ L33.mulN)

#level_report
