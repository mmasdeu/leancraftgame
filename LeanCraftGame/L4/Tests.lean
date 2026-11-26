/- Hidden test battery for Level 4: Anatomy of a theorem. -/
import LeanCraftGame.Referee
import LeanCraftGame.L4.Player

open L4

#no_sorry q1
#no_sorry q2
#no_sorry q3
#no_sorry q4
#no_sorry q5
#no_sorry q6
#no_sorry q7
#level_start "Anatomy of a theorem"

#expect_choice "Question 1: the explicit arguments of `mul_le_mul`" : q1 = 0
#expect_choice "Question 2: the conclusion of `mul_le_mul`" : q2 = 1
#expect_choice "Question 3: `a` and `b` in `add_pow_two`" : q3 = 0
#expect_choice "Question 4: what `[CommSemiring α]` is" : q4 = 2
#expect_choice "Question 5: `a ≤ b → a ^ n ≤ b ^ n` for all reals?" : q5 = false
#expect_choice "Question 6: applying `pow_le_pow_left₀`" : q6 = 1
#expect_choice "Question 7: what `le_div_iff₀ hc` says" : q7 = 0

#level_report
