/- Hidden test battery for Level Quantifiers in order. -/
import LeanCraftGame.Referee
import LeanCraftGame.L13.Player

open L13

#no_sorry HitsEverything
#no_sorry Unbounded
#level_start "Quantifiers in order"

#expect_true "HitsEverything (fun n => n) is true" unfolding HitsEverything :
  HitsEverything (fun n => n)
#expect_true "HitsEverything (fun n => n / 2) is true" unfolding HitsEverything :
  HitsEverything (fun n => n / 2)
#expect_false "HitsEverything (fun n => 2 * n) is false" unfolding HitsEverything :
  HitsEverything (fun n => 2 * n)
#expect_false "HitsEverything (fun _ => 0) is false" unfolding HitsEverything :
  HitsEverything (fun _ => 0)
#expect_true "Unbounded (fun n => n) is true" unfolding Unbounded :
  Unbounded (fun n => n)
#expect_true "Unbounded (fun n => if n % 2 = 0 then n else 0) is true (0, 0, 2, 0, 4, …)" unfolding Unbounded :
  Unbounded (fun n => if n % 2 = 0 then n else 0)
#expect_false "Unbounded (fun _ => 7) is false" unfolding Unbounded :
  Unbounded (fun _ => 7)
#expect_false "Unbounded (fun n => n % 2) is false" unfolding Unbounded :
  Unbounded (fun n => n % 2)

#level_report
