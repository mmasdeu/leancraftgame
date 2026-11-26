/- Hidden test battery for Level 18: Reading a construction: Schröder–Bernstein. -/
import LeanCraftGame.Referee
import LeanCraftGame.L18.Player

open L18

#no_sorry q1
#no_sorry q2
#no_sorry q3
#no_sorry q4
#no_sorry q5
#no_sorry q6
#no_sorry q7
#no_sorry sbFun12
#no_sorry sbFun8
#level_start "Reading a construction: Schröder–Bernstein"

#expect_choice "Question 1: the definition by recursion" : q1 = 0
#expect_choice "Question 2: what `sbAux f g 0` is" : q2 = 1
#expect_choice "Question 3: the value of `sbFun` on `sbSet`" : q3 = 2
#expect_choice "Question 4: what `[Nonempty β]` is for" : q4 = true
#expect_choice "Question 5: is 3 in `sbSet f g`?" : q5 = true
#expect_choice "Question 6: is 12 in `sbSet f g`?" : q6 = true
#expect_choice "Question 7: is 8 in `sbSet f g`?" : q7 = false
#expect_choice "the value of `sbFun f g 12`" : sbFun12 = 24
#expect_choice "the value of `sbFun f g 8`" : sbFun8 = 4

#level_report
