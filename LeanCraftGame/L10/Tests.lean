/- Hidden test battery for Level Integers and casts. -/
import LeanCraftGame.Referee
import LeanCraftGame.L16.Player

open L16

#no_sorry diff
#no_sorry distance
#no_sorry IsNegative
#level_start "Integers and casts"

#expect_true "diff 3 5 = -2" unfolding diff :
  diff 3 5 = -2
#expect_true "diff 5 3 = 2" unfolding diff :
  diff 5 3 = 2
#expect_true "diff 0 0 = 0" unfolding diff :
  diff 0 0 = 0
#expect_true "distance 3 (-4) = 7" unfolding distance :
  distance 3 (-4) = 7
#expect_true "distance (-4) 3 = 7" unfolding distance :
  distance (-4) 3 = 7
#expect_true "distance 2 2 = 0" unfolding distance :
  distance 2 2 = 0
#expect_true "IsNegative (-1) is true" unfolding IsNegative :
  IsNegative (-1)
#expect_false "IsNegative 0 is false" unfolding IsNegative :
  IsNegative 0
#expect_false "IsNegative 5 is false" unfolding IsNegative :
  IsNegative 5

#level_report
