/- Hidden test battery for Level Integers and casts. -/
import LeanCraftGame.Referee
import LeanCraftGame.L12.Player

open L12

#no_sorry diff
#no_sorry gap
#no_sorry IsOddInt
#level_start "Integers and casts"

#expect_true "diff 3 5 = -2" unfolding diff :
  diff 3 5 = -2
#expect_true "diff 5 3 = 2" unfolding diff :
  diff 5 3 = 2
#expect_true "diff 0 7 = -7" unfolding diff :
  diff 0 7 = -7
#expect_true "(-7) / 2 = -4 and (-7) % 2 = 1 on ℤ" :
  (-7 : ℤ) / 2 = -4 ∧ (-7 : ℤ) % 2 = 1
#expect_true "gap 3 (-4) = 7" unfolding gap :
  gap 3 (-4) = 7
#expect_true "gap (-4) 3 = 7" unfolding gap :
  gap (-4) 3 = 7
#expect_true "gap (-2) (-2) = 0" unfolding gap :
  gap (-2) (-2) = 0
#expect_true "IsOddInt 7" unfolding IsOddInt :
  IsOddInt 7
#expect_true "IsOddInt (-3): negative numbers can be odd" unfolding IsOddInt :
  IsOddInt (-3)
#expect_false "IsOddInt (-4)" unfolding IsOddInt :
  IsOddInt (-4)
#expect_false "IsOddInt 0" unfolding IsOddInt :
  IsOddInt 0

#level_report
