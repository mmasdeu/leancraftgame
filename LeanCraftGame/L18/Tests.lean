/- Hidden test battery for Level Bounded quantifiers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L18.Player

open L18

#no_sorry HasPositiveRoot
#no_sorry EventuallyZero
#level_start "Bounded quantifiers"

-- the worked example
#expect_true "EventuallyBig (fun n => n) is true" unfolding EventuallyBig :
  EventuallyBig (fun n => n)
#expect_false "EventuallyBig (fun n => n % 2) is false" unfolding EventuallyBig :
  EventuallyBig (fun n => n % 2)
-- your predicates
#expect_true "HasPositiveRoot (fun n => n % 3) is true" unfolding HasPositiveRoot :
  HasPositiveRoot (fun n => n % 3)
#expect_false "HasPositiveRoot (fun n => n) is false (its only root is 0)" unfolding HasPositiveRoot :
  HasPositiveRoot (fun n => n)
#expect_false "HasPositiveRoot (fun n => n + 1) is false" unfolding HasPositiveRoot :
  HasPositiveRoot (fun n => n + 1)
#expect_true "EventuallyZero (fun n => if n < 5 then 7 else 0) is true" unfolding EventuallyZero :
  EventuallyZero (fun n => if n < 5 then 7 else 0)
#expect_true "EventuallyZero (fun _ => 0) is true" unfolding EventuallyZero :
  EventuallyZero (fun _ => 0)
#expect_false "EventuallyZero (fun n => n % 2) is false (0, 1, 0, 1, … keeps returning to 1)" unfolding EventuallyZero :
  EventuallyZero (fun n => n % 2)
#expect_false "EventuallyZero (fun n => n) is false" unfolding EventuallyZero :
  EventuallyZero (fun n => n)

#level_report
