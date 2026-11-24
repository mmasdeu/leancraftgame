/- Hidden test battery for Level Using Mathlib. -/
import LeanCraftGame.Referee
import LeanCraftGame.L29.Player

open L29

#no_sorry IsPerfect
#no_sorry CommonDivisor
#no_sorry OneToOne
#level_start "Using Mathlib"

#expect_true "BigEven 6 is true" unfolding BigEven :
  BigEven 6
#expect_false "BigEven 7 is false" unfolding BigEven :
  BigEven 7
#expect_true "6 is perfect" unfolding IsPerfect :
  IsPerfect 6
#expect_true "28 is perfect" unfolding IsPerfect :
  IsPerfect 28
#expect_false "12 is not perfect (1 + 2 + 3 + 4 + 6 = 16)" unfolding IsPerfect :
  IsPerfect 12
#expect_false "1 is not perfect (its proper divisors sum to 0)" unfolding IsPerfect :
  IsPerfect 1
#expect_true "CommonDivisor 3 6 9 is true" unfolding CommonDivisor :
  CommonDivisor 3 6 9
#expect_true "CommonDivisor 5 0 0 is true" unfolding CommonDivisor :
  CommonDivisor 5 0 0
#expect_false "CommonDivisor 2 6 9 is false" unfolding CommonDivisor :
  CommonDivisor 2 6 9
#expect_false "CommonDivisor 12 6 9 is false" unfolding CommonDivisor :
  CommonDivisor 12 6 9
#expect_true "OneToOne (fun n => 2 * n) is true" unfolding OneToOne Function.Injective :
  OneToOne (fun n => 2 * n)
#expect_true "OneToOne (fun n => n + 3) is true" unfolding OneToOne Function.Injective :
  OneToOne (fun n => n + 3)
#expect_false "OneToOne (fun n => n / 2) is false" unfolding OneToOne Function.Injective :
  OneToOne (fun n => n / 2)
#expect_false "OneToOne (fun _ => 0) is false" unfolding OneToOne Function.Injective :
  OneToOne (fun _ => 0)

#level_report
