/- Hidden test battery for Level Naming things. -/
import LeanCraftGame.Referee
import LeanCraftGame.L1.Player

open L1

#no_sorry hardy
#no_sorry firstWay
#no_sorry secondWay
#level_start "Naming things"

#expect_true "hardy = 1729" unfolding hardy :
  hardy = 1729
#expect_true "firstWay = hardy: 1729 = 1³ + 12³" unfolding firstWay hardy :
  firstWay = hardy
#expect_true "secondWay = hardy: 1729 = 9³ + 10³" unfolding secondWay hardy :
  secondWay = hardy
#expect_true "hardy = 7 · 13 · 19" unfolding hardy :
  hardy = 7 * 13 * 19

#level_report
