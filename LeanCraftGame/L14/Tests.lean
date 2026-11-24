/- Hidden test battery for Level Challenge: Egyptian fractions. -/
import LeanCraftGame.Referee
import LeanCraftGame.L14.Player

open L14

#no_sorry absDiff
#no_sorry signum
#no_sorry ratio
#no_sorry IsEgyptian
#level_start "Challenge: Egyptian fractions"

#expect_true "absDiff 5 3 = 2 and absDiff 3 5 = 2" unfolding absDiff :
  absDiff 5 3 = 2 ∧ absDiff 3 5 = 2
#expect_true "absDiff 4 4 = 0 and absDiff 0 7 = 7" unfolding absDiff :
  absDiff 4 4 = 0 ∧ absDiff 0 7 = 7
#expect_true "signum 4 = 1 and signum (-7) = -1" unfolding signum :
  signum 4 = 1 ∧ signum (-7) = -1
#expect_true "signum 0 = 0" unfolding signum :
  signum 0 = 0
#expect_true "signum (x · y) = signum x · signum y for -5 ≤ x, y ≤ 5" unfolding signum :
  ∀ x ∈ Finset.Icc (-5 : ℤ) 5, ∀ y ∈ Finset.Icc (-5 : ℤ) 5, signum (x * y) = signum x * signum y
#expect_true "ratio 1 2 = 1 / 2 (not rounded down)" unfolding ratio :
  ratio 1 2 = 1 / 2
#expect_true "ratio 6 3 = 2" unfolding ratio :
  ratio 6 3 = 2
#expect_true "ratio 5 0 = 0" unfolding ratio :
  ratio 5 0 = 0
#expect_true "IsEgyptian (5 / 6) 2 3" unfolding IsEgyptian :
  IsEgyptian (5 / 6) 2 3
#expect_true "IsEgyptian (1 / 2) 4 4" unfolding IsEgyptian :
  IsEgyptian (1 / 2) 4 4
#expect_false "IsEgyptian (2 / 3) 2 2" unfolding IsEgyptian :
  IsEgyptian (2 / 3) 2 2
#expect_false "IsEgyptian (1 / 3) 0 3 (1/0 is not a unit fraction)" unfolding IsEgyptian :
  IsEgyptian (1 / 3) 0 3
#expect_false "IsEgyptian 0 2 2 (1/2 + 1/2 is 1, not 0)" unfolding IsEgyptian :
  IsEgyptian 0 2 2

#level_report
