/- Hidden test battery for Level Naming things. -/
import LeanCraftGame.Referee
import LeanCraftGame.L4.Player

open L4

#no_sorry answer
#no_sorry language
#no_sorry flag
#level_start "Naming things"

#expect_true "answer = 42" unfolding answer :
  answer = 42
#expect_true "answer + 1 = 43" unfolding answer :
  answer + 1 = 43
#expect_true "language is the text Lean (with a capital L)" unfolding language :
  language = "Lean"
#expect_true "flag = true" unfolding flag :
  flag = true

#level_report
