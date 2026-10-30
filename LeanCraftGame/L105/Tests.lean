/- Hidden test battery for Level Bounded and monotone. -/
import LeanCraftGame.Referee
import LeanCraftGame.L105.Player

open L105

#no_sorry BoundedAbove
#no_sorry Bounded
#no_sorry NonDecreasing
#no_sorry StrictlyIncreasing
#level_start "Level Bounded and monotone"

-- bounded above / bounded
#expect_true "BoundedAbove (-n) is true (0, -1, -2, …)" unfolding BoundedAbove :
  BoundedAbove (fun n => -(n : ℤ))
#expect_false "Bounded (-n) is false (0, -1, -2, … falls forever: bounded means on both sides)" unfolding Bounded :
  Bounded (fun n => -(n : ℤ))
#expect_false "BoundedAbove n is false (0, 1, 2, …)" unfolding BoundedAbove :
  BoundedAbove (fun n => (n : ℤ))
#expect_false "Bounded n is false (0, 1, 2, …)" unfolding Bounded :
  Bounded (fun n => (n : ℤ))
#expect_true "Bounded (1, -1, 1, -1, …) is true" unfolding Bounded :
  Bounded (fun n => if n % 2 = 0 then (1 : ℤ) else -1)
#expect_true "Bounded (a constant) is true" unfolding Bounded :
  Bounded (fun _ => (-5 : ℤ))
#expect_true "Bounded u implies BoundedAbove u" unfolding Bounded BoundedAbove :
  ∀ u : ℕ → ℤ, Bounded u → BoundedAbove u

-- monotone
#expect_true "NonDecreasing (n / 2) is true (0, 0, 1, 1, 2, …)" unfolding NonDecreasing :
  NonDecreasing (fun n => (n : ℤ) / 2)
#expect_false "StrictlyIncreasing (n / 2) is false (0, 0, 1, 1, …)" unfolding StrictlyIncreasing :
  StrictlyIncreasing (fun n => (n : ℤ) / 2)
#expect_true "StrictlyIncreasing (n) is true (it is a claim about m < n, not m ≤ n)" unfolding StrictlyIncreasing :
  StrictlyIncreasing (fun n => (n : ℤ))
#expect_true "StrictlyIncreasing (2n - 7) is true (negative values are fine)" unfolding StrictlyIncreasing :
  StrictlyIncreasing (fun n => 2 * (n : ℤ) - 7)
#expect_true "NonDecreasing (a constant) is true" unfolding NonDecreasing :
  NonDecreasing (fun _ => (3 : ℤ))
#expect_false "StrictlyIncreasing (a constant) is false" unfolding StrictlyIncreasing :
  StrictlyIncreasing (fun _ => (3 : ℤ))
#expect_false "NonDecreasing (-n) is false (it is going down, not up)" unfolding NonDecreasing :
  NonDecreasing (fun n => -(n : ℤ))
#expect_false "NonDecreasing (0, 1, 2, 0, 0, …) is false (up at first, then it falls back)" unfolding NonDecreasing :
  NonDecreasing (fun n => if n < 3 then (n : ℤ) else 0)
#expect_false "NonDecreasing (0, 1, 0, 1, …) is false" unfolding NonDecreasing :
  NonDecreasing (fun n => ((n % 2 : ℕ) : ℤ))
#expect_true "StrictlyIncreasing u implies u n < u (n + 1)" unfolding StrictlyIncreasing :
  ∀ u : ℕ → ℤ, StrictlyIncreasing u → ∀ n, u n < u (n + 1)
#expect_true "NonDecreasing u implies u n ≤ u (n + 1)" unfolding NonDecreasing :
  ∀ u : ℕ → ℤ, NonDecreasing u → ∀ n, u n ≤ u (n + 1)

#level_report
