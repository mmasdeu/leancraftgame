/- Hidden test battery for Level Continuity. -/
import LeanCraftGame.Referee
import LeanCraftGame.L110.Player

open L110

#no_sorry IsDeltaFor
#no_sorry ContAt
#level_start "Continuity"

-- the worked example
#expect_true "BoundedBy (fun _ => 3) 3 is true" unfolding BoundedBy :
  BoundedBy (fun _ => 3) 3
#expect_false "BoundedBy (fun x => x) 3 is false" unfolding BoundedBy :
  BoundedBy (fun x => x) 3
-- the inner part: concrete numbers
#expect_true "δ = 1/2 is good for ε = 1 for 2x at 0" unfolding IsDeltaFor :
  IsDeltaFor (fun x => 2 * x) 0 1 (1 / 2)
#expect_false "δ = 1 is too big for ε = 1 for 2x at 0" unfolding IsDeltaFor :
  IsDeltaFor (fun x => 2 * x) 0 1 1
#expect_false "δ = 0 is never good, even for a constant function" unfolding IsDeltaFor :
  IsDeltaFor (fun _ => 5) 0 1 0
#expect_false "a negative δ is never good" unfolding IsDeltaFor :
  IsDeltaFor (fun _ => 5) 0 1 (-1)
#expect_false "a jump of exactly ε is not within ε" unfolding IsDeltaFor :
  IsDeltaFor (fun x => if x ≤ 0 then 0 else 1) 0 1 1
#expect_true "a jump smaller than ε is fine" unfolding IsDeltaFor :
  IsDeltaFor (fun x => if x ≤ 0 then 0 else 1) 0 2 1
#expect_true "x is measured from a: δ = 1 is good for ε = 1 for x at 3" unfolding IsDeltaFor :
  IsDeltaFor (fun x => x) 3 1 1
#expect_true "f x is compared with f a: δ = 1 is good for ε = 1 for x + 1 at 2" unfolding IsDeltaFor :
  IsDeltaFor (fun x => x + 1) 2 1 1
-- continuity
#expect_true "a constant function is continuous" unfolding ContAt IsDeltaFor :
  ContAt (fun _ => 5) 3
#expect_true "x is continuous at 0" unfolding ContAt IsDeltaFor :
  ContAt (fun x => x) 0
#expect_true "x is continuous at 3" unfolding ContAt IsDeltaFor :
  ContAt (fun x => x) 3
#expect_true "x + 1 is continuous at 2" unfolding ContAt IsDeltaFor :
  ContAt (fun x => x + 1) 2
#expect_true "|x| is continuous at 0" unfolding ContAt IsDeltaFor :
  ContAt (fun x => |x|) 0
#expect_true "a step function is continuous away from its jump" unfolding ContAt IsDeltaFor :
  ContAt (fun x => if x ≤ 0 then 0 else 1) 1

#level_report
