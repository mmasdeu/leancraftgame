/- Hidden test battery for Level Making choices. -/
import LeanCraftGame.Referee
import LeanCraftGame.L3.Player

open L3

#no_sorry smallest
#no_sorry gap
#no_sorry zeroOrOne
#level_start "Making choices"

-- the worked example
#expect_true "biggest 3 8 = 8" unfolding biggest :
  biggest 3 8 = 8
#expect_true "biggest 8 3 = 8" unfolding biggest :
  biggest 8 3 = 8
-- your functions
#expect_true "smallest 3 8 = 3" unfolding smallest :
  smallest 3 8 = 3
#expect_true "smallest 8 3 = 3" unfolding smallest :
  smallest 8 3 = 3
#expect_true "smallest 5 5 = 5" unfolding smallest :
  smallest 5 5 = 5
#expect_true "gap 10 4 = 6" unfolding gap :
  gap 10 4 = 6
#expect_true "gap 4 10 = 6" unfolding gap :
  gap 4 10 = 6
#expect_true "gap 7 7 = 0" unfolding gap :
  gap 7 7 = 0
#expect_true "zeroOrOne 0 = 0" unfolding zeroOrOne :
  zeroOrOne 0 = 0
#expect_true "zeroOrOne 9 = 1" unfolding zeroOrOne :
  zeroOrOne 9 = 1

#level_report
