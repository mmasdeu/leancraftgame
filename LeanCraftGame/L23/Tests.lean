/- Hidden test battery for Level Generality. -/
import LeanCraftGame.Referee
import LeanCraftGame.L21.Player

open L21

#level_start "Generality"

-- the worked example
#expect_true "AlwaysBelow (fun n : ℕ => -(n : ℤ)) 0 is true" unfolding AlwaysBelow :
  AlwaysBelow (fun n : ℕ => -(n : ℤ)) 0
-- your definitions, on three types
#expect_true "Between (2 : ℕ) 5 5 is true" unfolding Between :
  Between (2 : ℕ) 5 5
#expect_true "Between (-3 : ℤ) 3 0 is true" unfolding Between :
  Between (-3 : ℤ) 3 0
#expect_false "Between (-3 : ℤ) 3 4 is false" unfolding Between :
  Between (-3 : ℤ) 3 4
#expect_true "Between (0 : ℚ) 1 (1 / 2) is true" unfolding Between :
  Between (0 : ℚ) 1 (1 / 2)
#expect_false "Between (0 : ℚ) 1 2 is false" unfolding Between :
  Between (0 : ℚ) 1 2
#expect_true "IsUpperBound {x : ℤ | x < 0} 0 is true" unfolding IsUpperBound :
  IsUpperBound {x : ℤ | x < 0} 0
#expect_false "IsUpperBound {x : ℤ | x < 5} 3 is false" unfolding IsUpperBound :
  IsUpperBound {x : ℤ | x < 5} 3
#expect_true "IsUpperBound {x : ℚ | x ≤ 1 / 2} 1 is true" unfolding IsUpperBound :
  IsUpperBound {x : ℚ | x ≤ 1 / 2} 1
#expect_true "largest (2 : ℕ) 9 = 9" unfolding largest :
  largest (2 : ℕ) 9 = 9
#expect_true "largest (-3 : ℤ) 2 = 2" unfolding largest :
  largest (-3 : ℤ) 2 = 2
#expect_true "largest (7 : ℤ) (-1) = 7" unfolding largest :
  largest (7 : ℤ) (-1) = 7

#level_report
