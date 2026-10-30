/- Hidden test battery for Level Order relations. -/
import LeanCraftGame.Referee
import LeanCraftGame.L113.Player

open L113

#level_start "Order relations"

#no_sorry PartialOrder'

-- genuine partial orders
#expect_model "≤ on ℕ is a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a ≤ b)
#expect_model "≥ on ℕ is a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => b ≤ a)
#expect_model "divisibility on ℕ is a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a ∣ b)
#expect_model "equality on ℕ is a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a = b)
#expect_model "≤ on Fin 3 is a partial order" :
  PartialOrder'.mk (α := Fin 3) (fun a b => a ≤ b)

-- junk
#expect_not_model "< on ℕ is not a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a < b)
#expect_not_model "≠ on ℕ is not a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a ≠ b)
#expect_not_model "the always-true relation is not a partial order" :
  PartialOrder'.mk (α := ℕ) (fun _ _ => True)
#expect_not_model "'differ by at most 1' is not a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a ≤ b + 1 ∧ b ≤ a + 1)
#expect_not_model "'a % 2 ≤ b % 2' is not a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a % 2 ≤ b % 2)
#expect_not_model "'a ≤ b + 1' is not a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a ≤ b + 1)

#level_report
