/- Hidden test battery for Level If, then. -/
import LeanCraftGame.Referee
import LeanCraftGame.L9.Player

open L9

#no_sorry FourThenTwo
#no_sorry TwoThenFour
#no_sorry breaksConverse
#no_sorry PrimeThenOdd
#no_sorry breaksPrimeOdd
#no_sorry SameParity
#level_start "If, then"

#expect_true "FourThenTwo 12 is true" unfolding FourThenTwo :
  FourThenTwo 12
#expect_true "FourThenTwo 3 is true (vacuously: 4 does not divide 3)" unfolding FourThenTwo :
  FourThenTwo 3
#expect_true "FourThenTwo n for every n < 100" unfolding FourThenTwo :
  ∀ n < 100, FourThenTwo n
#expect_true "TwoThenFour 8 is true" unfolding TwoThenFour :
  TwoThenFour 8
#expect_false "TwoThenFour 10 is false" unfolding TwoThenFour :
  TwoThenFour 10
#expect_true "TwoThenFour 7 is true (vacuously)" unfolding TwoThenFour :
  TwoThenFour 7
#expect_true "breaksConverse: 2 divides it and 4 does not" unfolding breaksConverse :
  2 ∣ breaksConverse ∧ ¬ 4 ∣ breaksConverse
#expect_true "PrimeThenOdd 7 and PrimeThenOdd 9 are true" unfolding PrimeThenOdd :
  PrimeThenOdd 7 ∧ PrimeThenOdd 9
#expect_false "PrimeThenOdd 2 is false" unfolding PrimeThenOdd :
  PrimeThenOdd 2
#expect_true "breaksPrimeOdd is an even prime" unfolding breaksPrimeOdd :
  Nat.Prime breaksPrimeOdd ∧ breaksPrimeOdd % 2 = 0
#expect_true "SameParity 4 10 is true" unfolding SameParity :
  SameParity 4 10
#expect_true "SameParity 3 5 is true (both sides of ↔ are false)" unfolding SameParity :
  SameParity 3 5
#expect_false "SameParity 2 3 is false" unfolding SameParity :
  SameParity 2 3
#expect_false "SameParity 3 2 is false" unfolding SameParity :
  SameParity 3 2
#expect_true "SameParity a b ↔ (a + b) % 2 = 0, for all a, b < 20" unfolding SameParity :
  ∀ a < 20, ∀ b < 20, SameParity a b ↔ (a + b) % 2 = 0

#level_report
