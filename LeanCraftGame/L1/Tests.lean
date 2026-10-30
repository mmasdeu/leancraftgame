/- Hidden test battery for Level Naming things. -/
import LeanCraftGame.Referee
import LeanCraftGame.L1.Player

open L1

#no_sorry answer
#no_sorry language
#no_sorry successor
#level_start "Naming things"

#expect_true "answer = 42" unfolding answer :
  answer = 42
#expect_true "successor = 43" unfolding successor :
  successor = 43
#expect_true "successor is one more than answer" unfolding answer successor :
  successor = answer + 1
#expect_true "language is the text Lean (with a capital L)" unfolding language :
  language = "Lean"

#level_report
