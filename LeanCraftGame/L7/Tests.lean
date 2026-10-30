/- Hidden test battery for Level And. -/
import LeanCraftGame.Referee
import LeanCraftGame.L8.Player

open L8

#no_sorry IsTeen
#no_sorry EvenInRange
#level_start "And"

-- the worked example
#expect_true "InRange 10 20 15 is true" unfolding InRange :
  InRange 10 20 15
#expect_true "InRange 10 20 10 is true" unfolding InRange :
  InRange 10 20 10
#expect_false "InRange 10 20 9 is false" unfolding InRange :
  InRange 10 20 9
#expect_false "InRange 10 20 21 is false" unfolding InRange :
  InRange 10 20 21
-- your predicates
#expect_true "IsTeen 13 is true" unfolding IsTeen InRange :
  IsTeen 13
#expect_true "IsTeen 19 is true" unfolding IsTeen InRange :
  IsTeen 19
#expect_true "IsTeen 15 is true" unfolding IsTeen InRange :
  IsTeen 15
#expect_false "IsTeen 12 is false" unfolding IsTeen InRange :
  IsTeen 12
#expect_false "IsTeen 20 is false" unfolding IsTeen InRange :
  IsTeen 20
#expect_true "EvenInRange 1 10 4 is true" unfolding EvenInRange InRange :
  EvenInRange 1 10 4
#expect_true "EvenInRange 1 10 10 is true" unfolding EvenInRange InRange :
  EvenInRange 1 10 10
#expect_false "EvenInRange 1 10 5 is false" unfolding EvenInRange InRange :
  EvenInRange 1 10 5
#expect_false "EvenInRange 1 10 12 is false" unfolding EvenInRange InRange :
  EvenInRange 1 10 12

#level_report
