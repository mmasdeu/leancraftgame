/- Hidden test battery for Level Making choices. -/
import LeanCraftGame.Referee
import LeanCraftGame.L3.Player

open L3

#no_sorry collatz
#no_sorry gap
#no_sorry rootCount
#level_start "Making choices"

#expect_true "collatz 6 = 3" unfolding collatz :
  collatz 6 = 3
#expect_true "collatz 7 = 22" unfolding collatz :
  collatz 7 = 22
#expect_true "collatz 1 = 4 (1 → 4 → 2 → 1 is a cycle)" unfolding collatz :
  collatz 1 = 4
#expect_true "collatz 0 = 0 (0 is even)" unfolding collatz :
  collatz 0 = 0
#expect_true "gap 3 8 = 5 and gap 8 3 = 5" unfolding gap :
  gap 3 8 = 5 ∧ gap 8 3 = 5
#expect_true "gap 4 4 = 0" unfolding gap :
  gap 4 4 = 0
#expect_true "gap is symmetric (all a, b < 12)" unfolding gap :
  ∀ a < 12, ∀ b < 12, gap a b = gap b a
#expect_true "gap satisfies the triangle inequality (all a, b, c < 8)" unfolding gap :
  ∀ a < 8, ∀ b < 8, ∀ c < 8, gap a c ≤ gap a b + gap b c
#expect_true "x² + 3x + 2 = (x + 1)(x + 2) has 2 roots" unfolding rootCount :
  rootCount 3 2 = 2
#expect_true "x² + 2x + 1 = (x + 1)² has 1 root" unfolding rootCount :
  rootCount 2 1 = 1
#expect_true "x² + x + 1 has no real root" unfolding rootCount :
  rootCount 1 1 = 0
#expect_true "x² has 1 root, x² + 1 has none" unfolding rootCount :
  rootCount 0 0 = 1 ∧ rootCount 0 1 = 0

#level_report
