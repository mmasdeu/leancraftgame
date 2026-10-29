/- Hidden test battery for Level Your first structure. -/
import DefGame.Referee
import DefGame.L14.Player

open L14

#level_start "Your first structure"

-- things that should be accepted
#expect_model "Interval [2, 5] is an interval" :
  Interval.mk 2 5
#expect_model "Interval [5, 5] is an interval" :
  Interval.mk 5 5
#expect_model "3 is a positive number" :
  PosNat.mk 3
-- junk that should be rejected
#expect_not_model "Interval [5, 2] is not an interval" :
  Interval.mk 5 2
#expect_not_model "Interval [1, 0] is not an interval" :
  Interval.mk 1 0
#expect_not_model "0 is not a positive number" :
  PosNat.mk 0

#level_report
