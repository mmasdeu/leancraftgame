/- Hidden test battery for Level Challenge: witnesses. -/
import LeanCraftGame.Referee
import LeanCraftGame.L5.Player

open L5

#no_sorry p₁
#no_sorry p₂
#no_sorry q₁
#no_sorry q₂
#no_sorry slow
#no_sorry x
#no_sorry y
#no_sorry z
#level_start "Challenge: witnesses"

#expect_true "p₁² + p₂² = q₁² + q₂²" unfolding p₁ p₂ q₁ q₂ :
  p₁ ^ 2 + p₂ ^ 2 = q₁ ^ 2 + q₂ ^ 2
#expect_true "The two ways are different: 0 < p₁ < p₂, 0 < q₁ < q₂ and p₁ < q₁" unfolding p₁ p₂ q₁ q₂ :
  0 < p₁ ∧ p₁ < p₂ ∧ 0 < q₁ ∧ q₁ < q₂ ∧ p₁ < q₁
#expect_true "slow < 50 and slow does not reach 1 in the first 100 steps" unfolding slow iter collatz :
  slow < 50 ∧ ∀ k ≤ 100, iter k slow ≠ 1
#expect_true "slow reaches 1 within 200 steps" unfolding slow iter collatz :
  ∃ k ≤ 200, iter k slow = 1
#expect_true "x² + y² = z²" unfolding x y z :
  x ^ 2 + y ^ 2 = z ^ 2
#expect_true "The triple is primitive, with z > 20 and x, y > 0" unfolding x y z :
  Nat.gcd x y = 1 ∧ 20 < z ∧ 0 < x ∧ 0 < y

#level_report
