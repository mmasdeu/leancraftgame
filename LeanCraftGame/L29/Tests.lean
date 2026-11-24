/- Hidden test battery for Level Using Mathlib. -/
import LeanCraftGame.Referee
import LeanCraftGame.L29.Player

open L29

#no_sorry IsAbundant
#no_sorry CommonDivisor
#no_sorry OneToOne
#level_start "Using Mathlib"

#expect_true "BigEven 6 is true" unfolding BigEven :
  BigEven 6
#expect_false "BigEven 7 is false" unfolding BigEven :
  BigEven 7
#expect_true "12 is abundant (1 + 2 + 3 + 4 + 6 = 16)" unfolding IsAbundant :
  IsAbundant 12
#expect_true "18 and 20 are abundant" unfolding IsAbundant :
  IsAbundant 18 ∧ IsAbundant 20
#expect_false "6 is not abundant (it is perfect)" unfolding IsAbundant :
  IsAbundant 6
#expect_false "13 is not abundant (a prime: its proper divisors sum to 1)" unfolding IsAbundant :
  IsAbundant 13
#expect_true "No odd number below 100 is abundant" unfolding IsAbundant :
  ∀ n < 100, n % 2 = 1 → ¬ IsAbundant n
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
