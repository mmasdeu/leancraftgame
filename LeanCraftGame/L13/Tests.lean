/- Hidden test battery for Level For all. -/
import LeanCraftGame.Referee
import LeanCraftGame.L13.Player

open L13

#no_sorry AlwaysBelow
#no_sorry AllEven
#level_start "For all"

-- the worked example
#expect_true "AllBig (fun n => n + 10) is true" unfolding AllBig :
  AllBig (fun n => n + 10)
#expect_false "AllBig (fun n => n) is false" unfolding AllBig :
  AllBig (fun n => n)
-- your predicates
#expect_true "AlwaysBelow (fun n => n % 3) 2 is true" unfolding AlwaysBelow :
  AlwaysBelow (fun n => n % 3) 2
#expect_true "AlwaysBelow (fun _ => 4) 4 is true" unfolding AlwaysBelow :
  AlwaysBelow (fun _ => 4) 4
#expect_false "AlwaysBelow (fun n => n % 3) 1 is false" unfolding AlwaysBelow :
  AlwaysBelow (fun n => n % 3) 1
#expect_false "AlwaysBelow (fun n => n) 5 is false" unfolding AlwaysBelow :
  AlwaysBelow (fun n => n) 5
#expect_true "AllEven (fun n => 2 * n) is true" unfolding AllEven :
  AllEven (fun n => 2 * n)
#expect_true "AllEven (fun _ => 0) is true" unfolding AllEven :
  AllEven (fun _ => 0)
#expect_false "AllEven (fun n => n) is false" unfolding AllEven :
  AllEven (fun n => n)
#expect_false "AllEven (fun n => 2 * n + 1) is false" unfolding AllEven :
  AllEven (fun n => 2 * n + 1)

#level_report
