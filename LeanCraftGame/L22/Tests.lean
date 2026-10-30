/- Hidden test battery for Level Using Mathlib. -/
import LeanCraftGame.Referee
import LeanCraftGame.L20.Player

open L20

#no_sorry TwinPrime
#no_sorry CommonDivisor
#no_sorry OneToOne
#level_start "Using Mathlib"

-- the worked example
#expect_true "BigEven 6 is true" unfolding BigEven :
  BigEven 6
#expect_false "BigEven 2 is false" unfolding BigEven :
  BigEven 2
#expect_false "BigEven 7 is false" unfolding BigEven :
  BigEven 7
-- your definitions
#expect_true "TwinPrime 5 is true" unfolding TwinPrime :
  TwinPrime 5
#expect_true "TwinPrime 11 is true" unfolding TwinPrime :
  TwinPrime 11
#expect_false "TwinPrime 7 is false" unfolding TwinPrime :
  TwinPrime 7
#expect_false "TwinPrime 2 is false" unfolding TwinPrime :
  TwinPrime 2
#expect_true "CommonDivisor 3 6 9 is true" unfolding CommonDivisor :
  CommonDivisor 3 6 9
#expect_true "CommonDivisor 5 0 0 is true" unfolding CommonDivisor :
  CommonDivisor 5 0 0
#expect_false "CommonDivisor 2 6 9 is false" unfolding CommonDivisor :
  CommonDivisor 2 6 9
#expect_true "OneToOne (fun n => 2 * n) is true" unfolding OneToOne Function.Injective Function.Surjective :
  OneToOne (fun n => 2 * n)
#expect_true "OneToOne (fun n => n + 3) is true" unfolding OneToOne Function.Injective Function.Surjective :
  OneToOne (fun n => n + 3)
#expect_false "OneToOne (fun n => n / 2) is false" unfolding OneToOne Function.Injective Function.Surjective :
  OneToOne (fun n => n / 2)
#expect_false "OneToOne (fun _ => 0) is false" unfolding OneToOne Function.Injective Function.Surjective :
  OneToOne (fun _ => 0)

#level_report
