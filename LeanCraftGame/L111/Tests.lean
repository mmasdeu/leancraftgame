/- Hidden test battery for Level Cauchy sequences. -/
import LeanCraftGame.Referee
import LeanCraftGame.L111.Player

open L111

#no_sorry IsEventuallyConstant
#no_sorry IsCauchy
#level_start "Cauchy sequences"

-- the worked example
#expect_true "the constant sequence 3 converges to 3" unfolding ConvergesTo :
  ConvergesTo (fun _ => 3) 3
-- the warm-up
#expect_true "7, 7, 7, 7, 7, 0, 0, 0, … is eventually constant" unfolding IsEventuallyConstant :
  IsEventuallyConstant (fun n => if n < 5 then 7 else 0)
#expect_false "0, 1, 2, 3, … is not eventually constant" unfolding IsEventuallyConstant :
  IsEventuallyConstant (fun n => (n : ℝ))
#expect_false "0, 1, 0, 1, … is not eventually constant" unfolding IsEventuallyConstant :
  IsEventuallyConstant (fun n => if n % 2 = 0 then 0 else 1)
-- Cauchy
#expect_true "the constant sequence 3 is Cauchy" unfolding IsCauchy :
  IsCauchy (fun _ => 3)
#expect_true "7, 7, 7, 7, 7, 0, 0, 0, … is Cauchy" unfolding IsCauchy :
  IsCauchy (fun n => if n < 5 then 7 else 0)
#expect_true "1, 0, 0, 0, … is Cauchy: the first terms never matter" unfolding IsCauchy :
  IsCauchy (fun n => if n = 0 then 1 else 0)
#expect_false "0, 1, 2, 3, … is not Cauchy" unfolding IsCauchy :
  IsCauchy (fun n => (n : ℝ))
#expect_false "0, 1, 0, 1, … is not Cauchy" unfolding IsCauchy :
  IsCauchy (fun n => if n % 2 = 0 then 0 else 1)

#level_report
