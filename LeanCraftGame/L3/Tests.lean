/- Hidden test battery for Level 3: How Lean parses. -/
import LeanCraftGame.Referee
import LeanCraftGame.L3.Player

open L3

#no_sorry q1
#no_sorry q2
#no_sorry q3
#no_sorry q4
#no_sorry q5
#no_sorry q6
#no_sorry q7
#no_sorry q8
#level_start "How Lean parses"

#expect_choice "Question 1: `-x ^ 2` at x = 3" : q1 = 1
#expect_choice "Question 2: `2 * 3 + 4`" : q2 = 0
#expect_choice "Question 3: `8 / 4 * 2`" : q3 = 1
#expect_choice "Question 4: `3 - 5 + 4` in ℕ" : q4 = 1
#expect_choice "Question 5: `2 ^ 3 ^ 2`" : q5 = 1
#expect_choice "Question 6: `f 3 + 1` with f x = 2x" : q6 = 0
#expect_choice "Question 7: the brackets in `a - b - c`" : q7 = 0
#expect_choice "Question 8: the brackets in `f x ^ 2`" : q8 = 0

#level_report
