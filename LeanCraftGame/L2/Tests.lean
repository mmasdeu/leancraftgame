/- Hidden test battery for Level 2: Your first definitions. -/
import LeanCraftGame.Referee
import LeanCraftGame.L2.Player

open L2

#no_sorry square
#no_sorry am
#no_sorry double
#no_sorry twelve
#no_sorry halfNat
#level_start "Your first definitions"

#expect_true "square 3 = 9" unfolding square : square 3 = 9
#expect_true "square (-2) = 4: a square is never negative" unfolding square : square (-2) = 4
#expect_true "am 1 2 = 3 / 2" unfolding am : am 1 2 = 3 / 2
#expect_true "am 2 2 = 2: the mean of a number with itself" unfolding am : am 2 2 = 2
#expect_true "am 0 4 = 2: the mean lies halfway (watch the brackets)" unfolding am : am 0 4 = 2
#expect_true "double 5 = 10" unfolding double : double 5 = 10
#expect_true "twelve = 12" unfolding twelve double : twelve = 12
#expect_true "halfNat 7 = 3: division in ℕ rounds down" unfolding halfNat : halfNat 7 = 3
#expect_true "halfNat 10 = 5" unfolding halfNat : halfNat 10 = 5

#level_report
