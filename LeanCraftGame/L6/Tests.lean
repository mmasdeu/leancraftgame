/- Hidden test battery for Level 6: Generic statements. -/
import LeanCraftGame.Referee
import LeanCraftGame.L6.Player

#no_sorry L6.sq_sub_sq'
#no_sorry L6.absorb
#no_sorry L6.max_comm'
#no_sorry L6.dist_triangle'
#level_start "Generic statements"

#expect_equiv "sq_sub_sq' says (a + b)(a - b) = a² - b² in every commutative ring" :
  L6.sq_sub_sq' ↔ ∀ {R : Type} [CommRing R] (a b : R), (a + b) * (a - b) = a ^ 2 - b ^ 2
  using fun a b => by ring
#expect_equiv "absorb says x ⊓ (x ⊔ y) = x in every lattice" :
  L6.absorb ↔ ∀ {α : Type} [Lattice α] (x y : α), x ⊓ (x ⊔ y) = x
  using fun x y => inf_sup_self
#expect_equiv "max_comm' says max a b = max b a in every linear order" :
  L6.max_comm' ↔ ∀ {α : Type} [LinearOrder α] (a b : α), max a b = max b a
  using fun a b => max_comm a b
#expect_equiv "dist_triangle' is the triangle inequality in every metric space" :
  L6.dist_triangle' ↔ ∀ {X : Type} [MetricSpace X] (x y z : X), dist x z ≤ dist x y + dist y z
  using fun x y z => dist_triangle x y z
#expect_type "sq_sub_sq' can be used as `h 3 2` for integers" :
  (fun h : L6.sq_sub_sq' => h (3 : ℤ) 2) : L6.sq_sub_sq' → _
#expect_type "max_comm' can be used as `h 1 2` for reals" :
  (fun h : L6.max_comm' => h (1 : ℝ) 2) : L6.max_comm' → _

#level_report
