/- Hidden test battery for Level Statements. -/
import LeanCraftGame.Referee
import LeanCraftGame.L7.Player

open L7

#no_sorry Divides
#no_sorry IsPythagorean
#no_sorry IsFixed
#level_start "Statements"

#expect_true "IsEven 10 is true" unfolding IsEven :
  IsEven 10
#expect_false "IsEven 7 is false" unfolding IsEven :
  IsEven 7
#expect_true "Divides 3 12 is true" unfolding Divides :
  Divides 3 12
#expect_false "Divides 5 12 is false" unfolding Divides :
  Divides 5 12
#expect_true "Divides 7 0 is true: everything divides 0" unfolding Divides :
  Divides 7 0
#expect_true "Divides 0 0 is true" unfolding Divides :
  Divides 0 0
#expect_false "Divides 0 5 is false" unfolding Divides :
  Divides 0 5
#expect_true "Divides 1 n for every n < 50" unfolding Divides :
  ∀ n < 50, Divides 1 n
#expect_true "IsPythagorean 3 4 5 is true" unfolding IsPythagorean :
  IsPythagorean 3 4 5
#expect_true "IsPythagorean 5 12 13 is true" unfolding IsPythagorean :
  IsPythagorean 5 12 13
#expect_false "IsPythagorean 4 3 6 is false" unfolding IsPythagorean :
  IsPythagorean 4 3 6
#expect_true "IsFixed 0 is true" unfolding IsFixed collatz :
  IsFixed 0
#expect_false "IsFixed 1 is false (1 → 4)" unfolding IsFixed collatz :
  IsFixed 1
#expect_true "0 is the only fixed point below 100" unfolding IsFixed collatz :
  ∀ n < 100, IsFixed n → n = 0

#level_report
