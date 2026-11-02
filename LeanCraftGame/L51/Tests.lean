/- Hidden test battery for Level Metric spaces. -/
import LeanCraftGame.Referee
import LeanCraftGame.L51.Player

open L51

#level_start "Metric spaces"

#no_sorry Metric'

-- genuine metrics (on the four points 0, 1, 2, 3)
#expect_model "|x - y| on {0, 1, 2, 3} is a metric" :
  Metric'.mk (α := Fin 4) (fun a b => (((a.val : ℤ) - b.val).natAbs : ℤ))
#expect_model "the discrete metric on {0, 1, 2, 3} is a metric" :
  Metric'.mk (α := Fin 4) (fun a b => if a = b then 0 else 1)
#expect_model "2 * |x - y| on {0, 1, 2, 3} is a metric" :
  Metric'.mk (α := Fin 4) (fun a b => 2 * (((a.val : ℤ) - b.val).natAbs : ℤ))
#expect_model "the distance between naturals, as a truncated difference, is a metric" :
  Metric'.mk (α := Fin 4) (fun a b => if a.val ≤ b.val then ((b.val - a.val : ℕ) : ℤ) else ((a.val - b.val : ℕ) : ℤ))

-- imposters
#expect_not_model "x - y is not a metric" :
  Metric'.mk (α := Fin 4) (fun a b => (a.val : ℤ) - b.val)
#expect_not_model "(x - y)^2 is not a metric" :
  Metric'.mk (α := Fin 4) (fun a b => ((a.val : ℤ) - b.val) ^ 2)
#expect_not_model "the zero distance is not a metric" :
  Metric'.mk (α := Fin 4) (fun _ _ => 0)
#expect_not_model "x + y is not a metric" :
  Metric'.mk (α := Fin 4) (fun a b => (a.val : ℤ) + b.val)
#expect_not_model "max x y is not a metric" :
  Metric'.mk (α := Fin 4) (fun a b => max (a.val : ℤ) b.val)
#expect_not_model "the parity distance is not a metric" :
  Metric'.mk (α := Fin 4) (fun a b => if a.val % 2 = b.val % 2 then 0 else 1)
#expect_not_model "the one-way distance is not a metric" :
  Metric'.mk (α := Fin 4) (fun a b => if a.val ≤ b.val then (b.val : ℤ) - a.val else 2 * ((a.val : ℤ) - b.val))
#expect_not_model "the constant distance 1 is not a metric" :
  Metric'.mk (α := Fin 4) (fun _ _ => 1)
#expect_not_model "-|x - y| is not a metric" :
  Metric'.mk (α := Fin 4) (fun a b => -(((a.val : ℤ) - b.val).natAbs : ℤ))

#level_report
