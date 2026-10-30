/- Hidden test battery for Level Sums. -/
import LeanCraftGame.Referee
import LeanCraftGame.L117.Player

open L117

#no_sorry squares
#no_sorry oddSum
#no_sorry sumBelow
#no_sorry sumBetween
#level_start "Sums"

#expect_true "sumOfDoubles 4 = 12 (the worked example)" unfolding sumOfDoubles :
  sumOfDoubles 4 = 12
#expect_true "squares 0 = 0 (the empty sum)" unfolding squares :
  squares 0 = 0
#expect_true "squares 1 = 1" unfolding squares :
  squares 1 = 1
#expect_true "squares 4 = 30 (1 + 4 + 9 + 16)" unfolding squares :
  squares 4 = 30
#expect_true "squares 10 = 385" unfolding squares :
  squares 10 = 385
#expect_true "oddSum 0 = 0" unfolding oddSum :
  oddSum 0 = 0
#expect_true "oddSum 1 = 1" unfolding oddSum :
  oddSum 1 = 1
#expect_true "oddSum 3 = 9 (1 + 3 + 5)" unfolding oddSum :
  oddSum 3 = 9
#expect_true "oddSum 7 = 49" unfolding oddSum :
  oddSum 7 = 49
#expect_true "sumBelow 0 = 0 (nothing is below 0)" unfolding sumBelow :
  sumBelow 0 = 0
#expect_true "sumBelow 1 = 0 (only 0 is below 1)" unfolding sumBelow :
  sumBelow 1 = 0
#expect_true "sumBelow 5 = 10 (0 + 1 + 2 + 3 + 4)" unfolding sumBelow :
  sumBelow 5 = 10
#expect_true "sumBetween 3 6 = 12 (3 + 4 + 5)" unfolding sumBetween :
  sumBetween 3 6 = 12
#expect_true "sumBetween 4 5 = 4 (only 4)" unfolding sumBetween :
  sumBetween 4 5 = 4
#expect_true "sumBetween 4 4 = 0 (nothing between 4 and 4)" unfolding sumBetween :
  sumBetween 4 4 = 0
#expect_true "sumBetween 6 3 = 0 (the wrong way round: empty)" unfolding sumBetween :
  sumBetween 6 3 = 0
#expect_true "sumBetween 0 4 = 6" unfolding sumBetween :
  sumBetween 0 4 = 6

#level_report
