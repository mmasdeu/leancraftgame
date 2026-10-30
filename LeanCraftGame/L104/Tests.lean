/- Hidden test battery for Level Challenge: patterns in sequences. -/
import LeanCraftGame.Referee
import LeanCraftGame.L104.Player

open L104

#no_sorry Periodic
#no_sorry EventuallyConstant
#no_sorry HasMaximum
#no_sorry EventuallyPeriodic
#level_start "Challenge: patterns in sequences"

#expect_true "Periodic (fun n => n % 3) is true" unfolding Periodic :
  Periodic (fun n => n % 3)
#expect_true "Periodic (fun _ => 5) is true" unfolding Periodic :
  Periodic (fun _ => 5)
#expect_false "Periodic (fun n => n) is false (p = 0 is not a period)" unfolding Periodic :
  Periodic (fun n => n)
#expect_false "Periodic (fun n => if n < 5 then 7 else 0) is false (irregular start)" unfolding Periodic :
  Periodic (fun n => if n < 5 then 7 else 0)

#expect_true "EventuallyConstant (fun n => if n < 5 then 7 else 0) is true" unfolding EventuallyConstant :
  EventuallyConstant (fun n => if n < 5 then 7 else 0)
#expect_true "EventuallyConstant (fun n => if n < 5 then 0 else 9) is true (the constant is not 0)" unfolding EventuallyConstant :
  EventuallyConstant (fun n => if n < 5 then 0 else 9)
#expect_false "EventuallyConstant (fun n => n) is false" unfolding EventuallyConstant :
  EventuallyConstant (fun n => n)
#expect_false "EventuallyConstant (fun n => n % 2) is false (keeps changing)" unfolding EventuallyConstant :
  EventuallyConstant (fun n => n % 2)

#expect_true "HasMaximum (fun n => n % 3) is true" unfolding HasMaximum :
  HasMaximum (fun n => n % 3)
#expect_true "HasMaximum (fun _ => 5) is true (the maximum may be reached many times)" unfolding HasMaximum :
  HasMaximum (fun _ => 5)
#expect_true "HasMaximum (fun n => if n < 5 then 7 else 0) is true" unfolding HasMaximum :
  HasMaximum (fun n => if n < 5 then 7 else 0)
#expect_false "HasMaximum (fun n => n) is false (every term is beaten by a later one)" unfolding HasMaximum :
  HasMaximum (fun n => n)
#expect_false "HasMaximum (fun n => n + 1) is false" unfolding HasMaximum :
  HasMaximum (fun n => n + 1)

#expect_true "EventuallyPeriodic (fun n => if n < 5 then 7 else 0) is true" unfolding EventuallyPeriodic :
  EventuallyPeriodic (fun n => if n < 5 then 7 else 0)
#expect_true "EventuallyPeriodic (fun n => n % 3) is true" unfolding EventuallyPeriodic :
  EventuallyPeriodic (fun n => n % 3)
#expect_false "EventuallyPeriodic (fun n => n) is false (p = 0 is not a period)" unfolding EventuallyPeriodic :
  EventuallyPeriodic (fun n => n)

#level_report
