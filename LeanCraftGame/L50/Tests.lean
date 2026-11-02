/- Hidden test battery for Level Order relations. -/
import LeanCraftGame.Referee
import LeanCraftGame.L50.Player

open L50

#level_start "Order relations"

#no_sorry PartialOrder'

-- genuine partial orders
#expect_model "≤ on ℕ is a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => a ≤ b)
#expect_model "≥ on ℕ is a partial order" :
  PartialOrder'.mk (α := ℕ) (fun a b => b ≤ a)
#expect_model "divisibility on {0, …, 6} is a partial order" :
  PartialOrder'.mk (α := Fin 7) (fun a b => a.val ∣ b.val)
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
#expect_not_model "'differ by at most 1' on {0, 1, 2} is not a partial order" :
  PartialOrder'.mk (α := Fin 3) (fun a b => a.val ≤ b.val + 1 ∧ b.val ≤ a.val + 1)
#expect_not_model "'a % 2 ≤ b % 2' on {0, …, 3} is not a partial order" :
  PartialOrder'.mk (α := Fin 4) (fun a b => a.val % 2 ≤ b.val % 2)
#expect_not_model "'equal or next' on {0, 1, 2} is not a partial order" :
  PartialOrder'.mk (α := Fin 3) (fun a b => a.val = b.val ∨ a.val + 1 = b.val)

#level_report
