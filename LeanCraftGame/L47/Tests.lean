/- Hidden test battery for Level Challenge: matrices. -/
import LeanCraftGame.Referee
import LeanCraftGame.L47.Player

open L47

#no_sorry pow
#no_sorry fibMatrix
#no_sorry fibM
#no_sorry order6
#level_start "Challenge: matrices"

#expect_true "M⁰ is the identity" unfolding pow :
  ((pow ⟨2, 3, 5, 7⟩ 0).a = 1 ∧ (pow ⟨2, 3, 5, 7⟩ 0).b = 0 ∧ (pow ⟨2, 3, 5, 7⟩ 0).c = 0 ∧ (pow ⟨2, 3, 5, 7⟩ 0).d = 1)
#expect_true "fibM 10 = 55" unfolding fibM pow fibMatrix mul :
  fibM 10 = 55
#expect_true "fibM n = Nat.fib n for every n < 25" unfolding fibM pow fibMatrix mul :
  ∀ n < 25, fibM n = (Nat.fib n : ℤ)
#expect_true "Cassini: det (fibMatrix ^ n) = (-1)ⁿ for n < 15" unfolding pow fibMatrix mul det :
  ∀ n < 15, det (pow fibMatrix n) = (-1) ^ n
#expect_true "order6 ^ 6 is the identity" unfolding order6 pow mul :
  ((pow order6 6).a = 1 ∧ (pow order6 6).b = 0 ∧ (pow order6 6).c = 0 ∧ (pow order6 6).d = 1)
#expect_true "order6 ^ k is not the identity for k = 1, …, 5" unfolding order6 pow mul :
  ∀ k ∈ Finset.Icc 1 5, ¬ ((pow order6 k).a = 1 ∧ (pow order6 k).b = 0 ∧ (pow order6 k).c = 0 ∧ (pow order6 k).d = 1)
#expect_true "order6 has determinant 1 and trace 1" unfolding order6 det :
  det order6 = 1 ∧ order6.a + order6.d = 1

#level_report
