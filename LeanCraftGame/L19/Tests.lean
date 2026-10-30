/- Hidden test battery for Level 19. Players don't edit (or ideally see) this file. -/
import LeanCraftGame.Referee
import LeanCraftGame.L19.Player

open L19

#no_sorry TendsToInfinity
#level_start "Level 19 · Going to infinity"

-- Sanity: things that should tend to infinity
#expect_true "u n = n tends to infinity" unfolding TendsToInfinity :
  TendsToInfinity (fun n => n)
#expect_true "u n = n / 2 tends to infinity (it is not strictly increasing!)" unfolding TendsToInfinity :
  TendsToInfinity (fun n => n / 2)
#expect_true "0, 4, 2, 6, 4, 8, … tends to infinity (it is not monotone!)" unfolding TendsToInfinity :
  TendsToInfinity (fun n => n + 3 * (n % 2))

-- Anti-theorems: things that should NOT tend to infinity
#expect_false "a constant sequence does not tend to infinity" unfolding TendsToInfinity :
  TendsToInfinity (fun _ => 7)
#expect_false "0, 1, 0, 1, … does not tend to infinity" unfolding TendsToInfinity :
  TendsToInfinity (fun n => n % 2)
#expect_false "0, 0, 2, 0, 4, 0, … does not tend to infinity (unbounded is not enough!)" unfolding TendsToInfinity :
  TendsToInfinity (fun n => if n % 2 = 0 then n else 0)

-- Downstream lemmas: what users of your definition will need
#expect_true "if u → ∞ then u is unbounded" unfolding TendsToInfinity :
  ∀ u : Nat → Nat, TendsToInfinity u → ∀ M, ∃ n, M ≤ u n
#expect_true "if u → ∞ then (u n + 1) → ∞" unfolding TendsToInfinity :
  ∀ u : Nat → Nat, TendsToInfinity u → TendsToInfinity (fun n => u n + 1)
#expect_true "if u → ∞ then the shifted sequence u (n+1) → ∞" unfolding TendsToInfinity :
  ∀ u : Nat → Nat, TendsToInfinity u → TendsToInfinity (fun n => u (n + 1))

#level_report
