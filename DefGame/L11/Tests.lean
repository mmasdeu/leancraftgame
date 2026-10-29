/- Hidden test battery for Level If … then …. -/
import DefGame.Referee
import DefGame.L11.Player

open L11

#no_sorry LateBig
#no_sorry EvenToEven
#level_start "If … then …"

-- the worked example
#expect_true "BigAfter (fun n => if n < 3 then 0 else 10) is true" unfolding BigAfter :
  BigAfter (fun n => if n < 3 then 0 else 10)
#expect_false "BigAfter (fun n => n) is false" unfolding BigAfter :
  BigAfter (fun n => n)
-- your predicates
#expect_true "LateBig (fun n => n) is true" unfolding LateBig :
  LateBig (fun n => n)
#expect_true "LateBig (fun n => if n < 5 then 0 else 9) is true (the first terms are 0: that is fine!)" unfolding LateBig :
  LateBig (fun n => if n < 5 then 0 else 9)
#expect_false "LateBig (fun _ => 0) is false" unfolding LateBig :
  LateBig (fun _ => 0)
#expect_false "LateBig (fun n => n % 4) is false" unfolding LateBig :
  LateBig (fun n => n % 4)
#expect_true "EvenToEven (fun n => 2 * n) is true" unfolding EvenToEven :
  EvenToEven (fun n => 2 * n)
#expect_true "EvenToEven (fun n => n + 2) is true" unfolding EvenToEven :
  EvenToEven (fun n => n + 2)
#expect_false "EvenToEven (fun n => n + 1) is false" unfolding EvenToEven :
  EvenToEven (fun n => n + 1)

#level_report
