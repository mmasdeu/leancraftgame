/- Hidden test battery for Level Functions. -/
import LeanCraftGame.Referee
import LeanCraftGame.L2.Player

open L2

#no_sorry cube
#no_sorry triangular
#no_sorry handshakes
#level_start "Functions"

#expect_true "cube 1 + cube 12 = 1729" unfolding cube :
  cube 1 + cube 12 = 1729
#expect_true "cube 0 = 0" unfolding cube :
  cube 0 = 0
#expect_false "5 / 2 * 6 = 15 (division rounds down first)" :
  5 / 2 * 6 = 15
#expect_true "triangular 4 = 10" unfolding triangular :
  triangular 4 = 10
#expect_true "triangular 5 = 15" unfolding triangular :
  triangular 5 = 15
#expect_true "triangular 100 = 5050 (Gauss)" unfolding triangular :
  triangular 100 = 5050
#expect_true "8 · triangular n + 1 = (2n + 1)² for every n ≤ 30" unfolding triangular :
  ∀ n < 31, 8 * triangular n + 1 = (2 * n + 1) ^ 2
#expect_true "handshakes 4 = 6" unfolding handshakes :
  handshakes 4 = 6
#expect_true "handshakes 1 = 0 and handshakes 0 = 0" unfolding handshakes :
  handshakes 1 = 0 ∧ handshakes 0 = 0
#expect_true "handshakes (n + 1) = triangular n for every n ≤ 30" unfolding handshakes triangular :
  ∀ n < 31, handshakes (n + 1) = triangular n

#level_report
