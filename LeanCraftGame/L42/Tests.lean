/- Hidden test battery for Level 42: Matrices, bases and dimension. -/
import LeanCraftGame.Referee
import LeanCraftGame.L42.Player

open L42

#no_sorry rotM
#no_sorry fibM
#no_sorry fib
#no_sorry singular
#no_sorry detB
#level_start "Matrices, bases and dimension"

#expect_true "Reading: in !![1, 2; 3, 4], the entry in row 0, column 1 is 2" :
  (!![1, 2; 3, 4] : Matrix (Fin 2) (Fin 2) ℚ) 0 1 = 2
#expect_true "rotM sends ![1, 0] to ![0, 1]" unfolding rotM : rotM.mulVec ![1, 0] = ![0, 1]
#expect_true "rotM sends ![0, 1] to ![-1, 0]" unfolding rotM : rotM.mulVec ![0, 1] = ![-1, 0]
#expect_true "rotM ^ 4 is the identity" unfolding rotM : rotM ^ 4 = 1
#expect_true "rotM has determinant 1" unfolding rotM : rotM.det = 1
#expect_true "fib 1 = 1 and fib 2 = 1" unfolding fib fibM : fib 1 = 1 ∧ fib 2 = 1
#expect_true "fib 10 = 55" unfolding fib fibM : fib 10 = 55
#expect_true "fib 0 = 0" unfolding fib fibM : fib 0 = 0
#expect_true "singular has determinant 0" unfolding singular : singular.det = 0
#expect_true "singular has no zero entry" unfolding singular :
  singular 0 0 ≠ 0 ∧ singular 0 1 ≠ 0 ∧ singular 1 0 ≠ 0 ∧ singular 1 1 ≠ 0
#expect_true "detB is the determinant of !![2, 1; 7, 4]" unfolding detB :
  detB = (!![2, 1; 7, 4] : Matrix (Fin 2) (Fin 2) ℚ).det

#level_report
