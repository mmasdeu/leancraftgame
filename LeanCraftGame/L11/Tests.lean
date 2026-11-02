/- Hidden test battery for Level Spot the bug: connectives. -/
import LeanCraftGame.Referee
import LeanCraftGame.L11.Player

namespace L11Ref
def IsTeen (n : Nat) : Prop := 13 ≤ n ∨ n ≤ 19
def IsWeekend (d : Nat) : Prop := d = 6 ∧ d = 7
def BothOdd (a b : Nat) : Prop := ¬ a % 2 = 0 ∧ b % 2 = 0
end L11Ref

#no_sorry L11.teen
#no_sorry L11.weekendDay
#no_sorry L11.oddA
#no_sorry L11.oddB
#level_start "Spot the bug: connectives"

#expect_true "IsTeen accepts your number" unfolding L11Ref.IsTeen L11.teen :
  L11Ref.IsTeen L11.teen
#expect_true "your number is not from 13 to 19" unfolding L11.teen :
  ¬ (13 ≤ L11.teen ∧ L11.teen ≤ 19)
#expect_true "your day is a weekend day (6 or 7)" unfolding L11.weekendDay :
  L11.weekendDay = 6 ∨ L11.weekendDay = 7
#expect_true "IsWeekend rejects your day" unfolding L11Ref.IsWeekend L11.weekendDay :
  ¬ (L11Ref.IsWeekend L11.weekendDay)
#expect_true "BothOdd accepts your two numbers" unfolding L11Ref.BothOdd L11.oddA L11.oddB :
  L11Ref.BothOdd L11.oddA L11.oddB
#expect_true "your two numbers are not both odd" unfolding L11.oddA L11.oddB :
  ¬ (L11.oddA % 2 = 1 ∧ L11.oddB % 2 = 1)

#level_report
