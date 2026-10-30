/- Hidden test battery for Level Challenge: truncated arithmetic. -/
import LeanCraftGame.Referee
import LeanCraftGame.L103.Player

open L103

#no_sorry absDiff
#no_sorry signum
#no_sorry ratio
#no_sorry percent
#level_start "Challenge: truncated arithmetic"

#expect_true "absDiff 5 3 = 2" unfolding absDiff :
  absDiff 5 3 = 2
#expect_true "absDiff 3 5 = 2 (the smaller number comes first)" unfolding absDiff :
  absDiff 3 5 = 2
#expect_true "absDiff 4 4 = 0" unfolding absDiff :
  absDiff 4 4 = 0
#expect_true "absDiff 0 7 = 7" unfolding absDiff :
  absDiff 0 7 = 7
#expect_true "signum 4 = 1" unfolding signum :
  signum 4 = 1
#expect_true "signum (-7) = -1" unfolding signum :
  signum (-7) = -1
#expect_true "signum 0 = 0" unfolding signum :
  signum 0 = 0
#expect_true "signum 1 = 1" unfolding signum :
  signum 1 = 1
#expect_true "signum (-1) = -1" unfolding signum :
  signum (-1) = -1
#expect_true "ratio 1 2 = 1 / 2 (not rounded down)" unfolding ratio :
  ratio 1 2 = 1 / 2
#expect_true "ratio 6 3 = 2" unfolding ratio :
  ratio 6 3 = 2
#expect_true "ratio 3 4 = 3 / 4" unfolding ratio :
  ratio 3 4 = 3 / 4
#expect_true "ratio 5 0 = 0 (division by zero)" unfolding ratio :
  ratio 5 0 = 0
#expect_true "ratio 0 5 = 0" unfolding ratio :
  ratio 0 5 = 0
#expect_true "percent 1 2 = 50" unfolding percent :
  percent 1 2 = 50
#expect_true "percent 2 3 = 67 (rounded to nearest, not down)" unfolding percent :
  percent 2 3 = 67
#expect_true "percent 1 3 = 33" unfolding percent :
  percent 1 3 = 33
#expect_true "percent 1 8 = 13 (12.5 rounds up)" unfolding percent :
  percent 1 8 = 13
#expect_true "percent 3 8 = 38 (37.5 rounds up)" unfolding percent :
  percent 3 8 = 38
#expect_true "percent 7 7 = 100" unfolding percent :
  percent 7 7 = 100
#expect_true "percent 5 0 = 0 (division by zero)" unfolding percent :
  percent 5 0 = 0
#expect_true "percent 3 2 = 150 (more than 100 percent)" unfolding percent :
  percent 3 2 = 150

#level_report
