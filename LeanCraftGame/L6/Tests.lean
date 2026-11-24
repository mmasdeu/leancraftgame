/- Hidden test battery for Level Spot the bug. -/
import LeanCraftGame.Referee
import LeanCraftGame.L6.Player

open L6

#no_sorry median3
#no_sorry daysInYear
#level_start "Spot the bug"

#expect_true "median3 1 2 3 = 2" unfolding median3 :
  median3 1 2 3 = 2
#expect_true "median3 2 3 1 = 2" unfolding median3 :
  median3 2 3 1 = 2
#expect_true "median3 3 2 1 = 2" unfolding median3 :
  median3 3 2 1 = 2
#expect_true "median3 is right on every triple below 5" unfolding median3 :
  ∀ a < 5, ∀ b < 5, ∀ c < 5, median3 a b c = max (min a b) (min (max a b) c)
#expect_true "daysInYear 2023 = 365 and daysInYear 2024 = 366" unfolding daysInYear :
  daysInYear 2023 = 365 ∧ daysInYear 2024 = 366
#expect_true "daysInYear 1900 = 365 (a century)" unfolding daysInYear :
  daysInYear 1900 = 365
#expect_true "daysInYear 2000 = 366 (divisible by 400)" unfolding daysInYear :
  daysInYear 2000 = 366
#expect_true "400 consecutive years have 146097 days (= 20871 weeks exactly)" unfolding daysInYear :
  (List.range 400).foldl (fun s k => s + daysInYear (2000 + k)) 0 = 146097

#level_report
