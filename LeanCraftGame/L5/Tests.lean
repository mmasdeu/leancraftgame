/- Hidden test battery for Level Spot the bug (Basics). -/
import LeanCraftGame.Referee
import LeanCraftGame.L5.Player

-- the referee's own copies: the colleague's code, and the right answers
namespace L23Ref
def middle (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else c)
  else (if a ≤ c then a else c)
def median (a b c : Nat) : Nat := max (min a b) (min (max a b) c)
def isLeap (y : Nat) : Bool := y % 4 == 0 && y % 100 != 0
def isLeapRight (y : Nat) : Bool := y % 4 == 0 && (y % 100 != 0 || y % 400 == 0)
end L23Ref

#no_sorry L5.ma
#no_sorry L5.mb
#no_sorry L5.mc
#no_sorry L5.year
#level_start "Spot the bug"

#expect_true "middle gives the wrong answer on your three numbers" :
  L23Ref.middle L5.ma L5.mb L5.mc ≠ L23Ref.median L5.ma L5.mb L5.mc
#expect_true "isLeap gives the wrong answer on your year" :
  L23Ref.isLeap L5.year ≠ L23Ref.isLeapRight L5.year

#level_report
