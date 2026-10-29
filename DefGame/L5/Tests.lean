/- Hidden test battery for Level Functions. -/
import DefGame.Referee
import DefGame.L5.Player

open L5

#no_sorry double
#no_sorry squared
#no_sorry addTen
#no_sorry minusOne
#level_start "Functions"

#expect_true "double 0 = 0" unfolding double :
  double 0 = 0
#expect_true "double 7 = 14" unfolding double :
  double 7 = 14
#expect_true "squared 5 = 25" unfolding squared :
  squared 5 = 25
#expect_true "squared 0 = 0" unfolding squared :
  squared 0 = 0
#expect_true "squared 3 = 9" unfolding squared :
  squared 3 = 9
#expect_true "addTen 1 = 11" unfolding addTen :
  addTen 1 = 11
#expect_true "addTen 0 = 10" unfolding addTen :
  addTen 0 = 10
#expect_true "minusOne 5 = 4" unfolding minusOne :
  minusOne 5 = 4
#expect_true "minusOne 0 = 0" unfolding minusOne :
  minusOne 0 = 0

#level_report
