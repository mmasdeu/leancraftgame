/- Hidden test battery for Level Challenge: counting. -/
import LeanCraftGame.Referee
import LeanCraftGame.L101.Player

open L101

#no_sorry stairs
#no_sorry choose
#no_sorry countEven
#level_start "Challenge: counting"

#expect_true "stairs 0 = 1 (one way to climb nothing: do nothing)" :
  stairs 0 = 1
#expect_true "stairs 1 = 1" :
  stairs 1 = 1
#expect_true "stairs 2 = 2" :
  stairs 2 = 2
#expect_true "stairs 5 = 8" :
  stairs 5 = 8
#expect_true "stairs 10 = 89" :
  stairs 10 = 89
#expect_true "choose 4 2 = 6" :
  choose 4 2 = 6
#expect_true "choose 5 0 = 1 (one way to pick nothing)" :
  choose 5 0 = 1
#expect_true "choose 0 0 = 1" :
  choose 0 0 = 1
#expect_true "choose 3 5 = 0 (cannot pick more than there are)" :
  choose 3 5 = 0
#expect_true "choose 0 3 = 0" :
  choose 0 3 = 0
#expect_true "choose 5 5 = 1" :
  choose 5 5 = 1
#expect_true "choose 6 3 = 20" :
  choose 6 3 = 20
#expect_true "choose 10 4 = 210" :
  choose 10 4 = 210
#expect_true "countEven 0 = 1 (0 is even)" :
  countEven 0 = 1
#expect_true "countEven 1 = 1" :
  countEven 1 = 1
#expect_true "countEven 2 = 2" :
  countEven 2 = 2
#expect_true "countEven 7 = 4" :
  countEven 7 = 4
#expect_true "countEven 10 = 6" :
  countEven 10 = 6

#level_report
