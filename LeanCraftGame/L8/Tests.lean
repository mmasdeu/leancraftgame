/- Hidden test battery for Level 8: ∀ and →. -/
import LeanCraftGame.Referee
import LeanCraftGame.L8.Player

#no_sorry L8.FnUb
#no_sorry L8.FnLb
#no_sorry L8.MonotoneFn
#level_start "∀ and →"

#expect_true "3 is an upper bound of the constant function 3" unfolding L8.FnUb :
  L8.FnUb (fun _ => 3) 3
#expect_false "5 is an upper bound of x ↦ x" unfolding L8.FnUb :
  L8.FnUb (fun x => x) 5
#expect_true "0 is an upper bound of x ↦ min x 0" unfolding L8.FnUb :
  L8.FnUb (fun x => min x 0) 0
#expect_true "0 is a lower bound of x ↦ x²" unfolding L8.FnLb :
  L8.FnLb (fun x => x ^ 2) 0
#expect_false "1 is a lower bound of x ↦ x²" unfolding L8.FnLb :
  L8.FnLb (fun x => x ^ 2) 1
#expect_true "x ↦ 2x + 1 is monotone" unfolding L8.MonotoneFn :
  L8.MonotoneFn (fun x => 2 * x + 1)
#expect_false "x ↦ -x is monotone" unfolding L8.MonotoneFn :
  L8.MonotoneFn (fun x => -x)
#expect_false "x ↦ x² is monotone" unfolding L8.MonotoneFn :
  L8.MonotoneFn (fun x => x ^ 2)
#expect_equiv "MonotoneFn is Mathlib's Monotone" unfolding L8.MonotoneFn :
  ∀ f : ℝ → ℝ, L8.MonotoneFn f ↔ Monotone f
#expect_type "MonotoneFn takes a and b implicitly: `h hab` makes sense" :
  (fun (h : L8.MonotoneFn (fun x => x)) (hab : (1 : ℝ) ≤ 2) => h hab) : _ → _ → _

#level_report
