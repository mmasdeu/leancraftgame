/- Hidden test battery for Level 44: Metric spaces. -/
import LeanCraftGame.Referee
import LeanCraftGame.L38.Player

#no_sorry L38.UnifCont
#level_start "Metric spaces"

-- genuine metrics on the four points 0, 1, 2, 3
#expect_model "|x - y| on {0, 1, 2, 3} is a metric" :
  L38.Metric'.mk (α := Fin 4) (fun a b => (((a.val : ℤ) - b.val).natAbs : ℤ))
#expect_model "the discrete metric on {0, 1, 2, 3} is a metric" :
  L38.Metric'.mk (α := Fin 4) (fun a b => if a = b then 0 else 1)
#expect_model "2 · |x - y| on {0, 1, 2, 3} is a metric" :
  L38.Metric'.mk (α := Fin 4) (fun a b => 2 * (((a.val : ℤ) - b.val).natAbs : ℤ))

-- impostors
#expect_not_model "x - y is not a metric" :
  L38.Metric'.mk (α := Fin 4) (fun a b => (a.val : ℤ) - b.val)
#expect_not_model "(x - y)² is not a metric" :
  L38.Metric'.mk (α := Fin 4) (fun a b => ((a.val : ℤ) - b.val) ^ 2)
#expect_not_model "the zero distance is not a metric" :
  L38.Metric'.mk (α := Fin 4) (fun _ _ => 0)
#expect_not_model "the one-way distance is not a metric" :
  L38.Metric'.mk (α := Fin 4) (fun a b => if a.val ≤ b.val then (b.val : ℤ) - a.val else 2 * ((a.val : ℤ) - b.val))
#expect_not_model "the constant distance 1 is not a metric" :
  L38.Metric'.mk (α := Fin 4) (fun _ _ => 1)

#expect_equiv "UnifCont is uniform continuity in ε–δ form" unfolding L38.UnifCont :
  ∀ f, L38.UnifCont f ↔ ∀ ε > 0, ∃ δ > 0, ∀ x y, dist x y < δ → dist (f x) (f y) < ε

#level_report
