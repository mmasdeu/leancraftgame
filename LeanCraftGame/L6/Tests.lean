/- Hidden test battery for Level Spot the bug (Basics). -/
import LeanCraftGame.Referee
import LeanCraftGame.L6.Player

-- the referee's own copies: the colleague's code, and the right answers
namespace L6Ref
def middle (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else c)
  else (if a ≤ c then a else c)
def median (a b c : Nat) : Nat := max (min a b) (min (max a b) c)
def daysInYear (y : Nat) : Nat :=
  if y % 4 = 0 then (if y % 100 = 0 then 365 else 366) else 365
def daysInYearRight (y : Nat) : Nat :=
  if y % 4 = 0 then (if y % 100 = 0 then (if y % 400 = 0 then 366 else 365) else 366) else 365
end L6Ref

#no_sorry L6.ma
#no_sorry L6.mb
#no_sorry L6.mc
#no_sorry L6.year
#level_start "Spot the bug"

#expect_true "middle gives the wrong answer on your three numbers" :
  L6Ref.middle L6.ma L6.mb L6.mc ≠ L6Ref.median L6.ma L6.mb L6.mc
#expect_true "daysInYear gives the wrong answer on your year" :
  L6Ref.daysInYear L6.year ≠ L6Ref.daysInYearRight L6.year

#level_report
