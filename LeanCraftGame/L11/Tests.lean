/- Hidden test battery for Level Division by zero. -/
import LeanCraftGame.Referee
import LeanCraftGame.L11.Player

open L11

#no_sorry average
#no_sorry IsReciprocal
#no_sorry HasSlope
#level_start "Division by zero"

-- the worked example
#expect_true "IsHalf 6 3 is true" unfolding IsHalf :
  IsHalf 6 3
#expect_false "IsHalf 6 2 is false" unfolding IsHalf :
  IsHalf 6 2
-- your definitions
#expect_true "average 1 2 = 3 / 2" unfolding average :
  average 1 2 = 3 / 2
#expect_true "average (-1) 1 = 0" unfolding average :
  average (-1) 1 = 0
#expect_true "IsReciprocal 2 (1 / 2) is true" unfolding IsReciprocal :
  IsReciprocal 2 (1 / 2)
#expect_true "IsReciprocal (-4) (-1 / 4) is true" unfolding IsReciprocal :
  IsReciprocal (-4) (-1 / 4)
#expect_false "IsReciprocal 3 3 is false" unfolding IsReciprocal :
  IsReciprocal 3 3
#expect_false "IsReciprocal 0 0 is false (0 has no reciprocal)" unfolding IsReciprocal :
  IsReciprocal 0 0
#expect_true "HasSlope 0 0 2 6 3 is true" unfolding HasSlope :
  HasSlope 0 0 2 6 3
#expect_true "HasSlope 1 1 3 0 (-1 / 2) is true" unfolding HasSlope :
  HasSlope 1 1 3 0 (-1 / 2)
#expect_false "HasSlope 0 0 2 6 2 is false" unfolding HasSlope :
  HasSlope 0 0 2 6 2
#expect_false "HasSlope 1 0 1 5 0 is false (a vertical line has no slope)" unfolding HasSlope :
  HasSlope 1 0 1 5 0
#expect_false "HasSlope 1 2 1 2 0 is false (one point does not determine a line)" unfolding HasSlope :
  HasSlope 1 2 1 2 0

#level_report
