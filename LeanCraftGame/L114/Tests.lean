/- Hidden test battery for Level Metric spaces. -/
import LeanCraftGame.Referee
import LeanCraftGame.L114.Player

open L114

#level_start "Metric spaces"

#no_sorry Metric'

-- genuine metrics
#expect_model "|x - y| on ℤ is a metric" :
  Metric'.mk (α := ℤ) (fun x y => ((x - y).natAbs : ℤ))
#expect_model "the discrete metric on ℕ is a metric" :
  Metric'.mk (α := ℕ) (fun x y => if x = y then 0 else 1)
#expect_model "2 * |x - y| on ℤ is a metric" :
  Metric'.mk (α := ℤ) (fun x y => 2 * ((x - y).natAbs : ℤ))
#expect_model "the distance between naturals is a metric" :
  Metric'.mk (α := ℕ) (fun x y => if x ≤ y then ((y - x : ℕ) : ℤ) else ((x - y : ℕ) : ℤ))

-- imposters
#expect_not_model "x - y on ℤ is not a metric" :
  Metric'.mk (α := ℤ) (fun x y => x - y)
#expect_not_model "(x - y)^2 on ℤ is not a metric" :
  Metric'.mk (α := ℤ) (fun x y => (x - y) ^ 2)
#expect_not_model "the zero distance is not a metric" :
  Metric'.mk (α := ℤ) (fun _ _ => 0)
#expect_not_model "x + y on ℤ is not a metric" :
  Metric'.mk (α := ℤ) (fun x y => x + y)
#expect_not_model "max x y on ℤ is not a metric" :
  Metric'.mk (α := ℤ) (fun x y => max x y)
#expect_not_model "the parity distance on ℕ is not a metric" :
  Metric'.mk (α := ℕ) (fun x y => if x % 2 = y % 2 then 0 else 1)
#expect_not_model "the one-way distance on ℤ is not a metric" :
  Metric'.mk (α := ℤ) (fun x y => if x ≤ y then y - x else 2 * (x - y))
#expect_not_model "the constant distance 1 is not a metric" :
  Metric'.mk (α := ℤ) (fun _ _ => 1)
#expect_not_model "-|x - y| on ℤ is not a metric" :
  Metric'.mk (α := ℤ) (fun x y => -((x - y).natAbs : ℤ))

#level_report
