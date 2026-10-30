/- Hidden test battery for Level There exists. -/
import LeanCraftGame.Referee
import LeanCraftGame.L15.Player

open L15

#no_sorry HasZero
#no_sorry HasEvenBig
#level_start "There exists"

-- the worked example
#expect_true "HasBig (fun n => n) is true" unfolding HasBig :
  HasBig (fun n => n)
#expect_false "HasBig (fun n => n % 5) is false" unfolding HasBig :
  HasBig (fun n => n % 5)
-- your predicates
#expect_true "HasZero (fun n => n) is true" unfolding HasZero :
  HasZero (fun n => n)
#expect_true "HasZero (fun n => n % 3) is true" unfolding HasZero :
  HasZero (fun n => n % 3)
#expect_false "HasZero (fun n => n + 1) is false" unfolding HasZero :
  HasZero (fun n => n + 1)
#expect_true "HasEvenBig (fun n => n) is true" unfolding HasEvenBig :
  HasEvenBig (fun n => n)
#expect_false "HasEvenBig (fun n => 2 * n + 1) is false" unfolding HasEvenBig :
  HasEvenBig (fun n => 2 * n + 1)
#expect_false "HasEvenBig (fun n => n % 5) is false" unfolding HasEvenBig :
  HasEvenBig (fun n => n % 5)
#expect_false "HasEvenBig (fun n => if n = 0 then 4 else 11) is false (4 is even, 11 is big, but no term is both)" unfolding HasEvenBig :
  HasEvenBig (fun n => if n = 0 then 4 else 11)

#level_report
