/- Hidden test battery for Level Spot the bug: connectives. -/
import LeanCraftGame.Referee
import LeanCraftGame.L9.Player

namespace L24Ref
def IsTeen (n : Nat) : Prop := 13 ≤ n ∨ n ≤ 19
def IsWeekend (d : Nat) : Prop := d = 6 ∧ d = 7
def BothOdd (a b : Nat) : Prop := ¬ a % 2 = 0 ∧ b % 2 = 0
end L24Ref

#no_sorry L9.teen
#no_sorry L9.weekendDay
#no_sorry L9.oddA
#no_sorry L9.oddB
#level_start "Spot the bug: connectives"

#expect_true "IsTeen accepts your number" unfolding L24Ref.IsTeen L9.teen :
  L24Ref.IsTeen L9.teen
#expect_true "your number is not from 13 to 19" unfolding L9.teen :
  ¬ (13 ≤ L9.teen ∧ L9.teen ≤ 19)
#expect_true "your day is a weekend day (6 or 7)" unfolding L9.weekendDay :
  L9.weekendDay = 6 ∨ L9.weekendDay = 7
#expect_true "IsWeekend rejects your day" unfolding L24Ref.IsWeekend L9.weekendDay :
  ¬ (L24Ref.IsWeekend L9.weekendDay)
#expect_true "BothOdd accepts your two numbers" unfolding L24Ref.BothOdd L9.oddA L9.oddB :
  L24Ref.BothOdd L9.oddA L9.oddB
#expect_true "your two numbers are not both odd" unfolding L9.oddA L9.oddB :
  ¬ (L9.oddA % 2 = 1 ∧ L9.oddB % 2 = 1)

#level_report
