/- Hidden test battery for Level 33: Reading the hierarchy. -/
import LeanCraftGame.Referee
import LeanCraftGame.L33.Player

open L33

#no_sorry q1
#no_sorry q2
#no_sorry q3
#no_sorry q4
#no_sorry q5
#no_sorry q6
#no_sorry q7
#level_start "Reading the hierarchy"

#expect_choice "Question 1: what `Field ℝ` gives you" : q1 = 3
#expect_choice "Question 2: what `#check (-3 : ℕ)` does" : q2 = 2
#expect_choice "Question 3: `mul_comm` on 2 × 2 matrices" : q3 = false
#expect_choice "Question 4: the explicit arguments of `add_comm`" : q4 = 1
#expect_choice "Question 5: a lemma for `[Ring R]`, used on ℤ" : q5 = true
#expect_choice "Question 6: what `E` is" : q6 = 0
#expect_choice "Question 7: an instance `Field ℤ`" : q7 = false

#level_report
