/- Hidden test battery for Level Limits. -/
import DefGame.Referee
import DefGame.L22.Player

open L22

#no_sorry ConvergesTo
#level_start "Limits"

-- the worked example
#expect_true "BoundedSeq (fun _ => 3) is true" unfolding BoundedSeq :
  BoundedSeq (fun _ => 3)
-- your definition
#expect_true "the constant sequence 3 converges to 3" unfolding ConvergesTo :
  ConvergesTo (fun _ => 3) 3
#expect_true "7, 7, 7, 7, 7, 0, 0, 0, … converges to 0" unfolding ConvergesTo :
  ConvergesTo (fun n => if n < 5 then 7 else 0) 0
#expect_false "the constant sequence 3 does not converge to 4" unfolding ConvergesTo :
  ConvergesTo (fun _ => 3) 4
#expect_false "0, 1, 2, 3, … does not converge to 0" unfolding ConvergesTo :
  ConvergesTo (fun n => (n : ℝ)) 0
#expect_false "0, 1, 0, 1, … does not converge to 0" unfolding ConvergesTo :
  ConvergesTo (fun n => if n % 2 = 0 then 0 else 1) 0

#level_report
