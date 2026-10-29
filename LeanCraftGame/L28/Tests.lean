/- Hidden test battery for Level Spot the bug: the library. -/
import LeanCraftGame.Referee
import LeanCraftGame.L28.Player

namespace L28Ref
def CommonDivisor (d a b : ℕ) : Prop := a ∣ d ∧ b ∣ d
def TwinPrime (p : ℕ) : Prop := Nat.Prime p ∨ Nat.Prime (p + 2)
def multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}
end L28Ref

#no_sorry L28.cdD
#no_sorry L28.cdA
#no_sorry L28.cdB
#no_sorry L28.twin
#no_sorry L28.mulK
#no_sorry L28.mulN
#level_start "Spot the bug: the library"

#expect_true "CommonDivisor accepts your three numbers" unfolding L28Ref.CommonDivisor L28.cdD L28.cdA L28.cdB :
  L28Ref.CommonDivisor L28.cdD L28.cdA L28.cdB
#expect_false "cdD divides both cdA and cdB" unfolding L28.cdD L28.cdA L28.cdB :
  L28.cdD ∣ L28.cdA ∧ L28.cdD ∣ L28.cdB
#expect_true "TwinPrime accepts your number" unfolding L28Ref.TwinPrime L28.twin :
  L28Ref.TwinPrime L28.twin
#expect_false "your number and the number 2 above it are both prime" unfolding L28.twin :
  Nat.Prime L28.twin ∧ Nat.Prime (L28.twin + 2)
#expect_true "mulN ∈ multiplesOf mulK holds" unfolding L28Ref.multiplesOf L28.mulK L28.mulN :
  L28.mulN ∈ L28Ref.multiplesOf L28.mulK
#expect_false "mulN is a multiple of mulK" unfolding L28.mulK L28.mulN :
  L28.mulK ∣ L28.mulN

#level_report
