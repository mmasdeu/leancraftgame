/- Hidden test battery for Level 1: Reading a Lean file. -/
import LeanCraftGame.Referee
import LeanCraftGame.L1.Player

open L1

#no_sorry q1
#no_sorry q2
#no_sorry q3
#no_sorry q4
#no_sorry q5
#no_sorry q6
#level_start "Reading a Lean file"

#expect_choice "Question 1: the line that defines something" : q1 = 1
#expect_choice "Question 2: what `#check am` tells you" : q2 = 3
#expect_choice "Question 3: the value of `#eval (7 + 2) / 2`" : q3 = 2
#expect_choice "Question 4: is `am a b ≤ max a b` proved in this file?" : q4 = false
#expect_choice "Question 5: where `a` and `b` in `am_comm` come from" : q5 = 0
#expect_choice "Question 6: can a later line use the `example` by name?" : q6 = false

#level_report
