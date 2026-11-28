/- Hidden test battery for Level 9: ∃. -/
import LeanCraftGame.Referee
import LeanCraftGame.L11.Player

#no_sorry L11.FnHasUb
#no_sorry L11.FnHasLb
#no_sorry L11.bound
#no_sorry L11.root
#no_sorry L11.TakesBothSigns
#level_start "∃"

#expect_true "x ↦ min x 3 has an upper bound" unfolding L11.FnHasUb L11.FnUb :
  L11.FnHasUb (fun x => min x 3)
#expect_false "x ↦ x has an upper bound" unfolding L11.FnHasUb L11.FnUb :
  L11.FnHasUb (fun x => x)
#expect_true "x ↦ x² has a lower bound" unfolding L11.FnHasLb L11.FnLb :
  L11.FnHasLb (fun x => x ^ 2)
#expect_false "x ↦ x has a lower bound" unfolding L11.FnHasLb L11.FnLb :
  L11.FnHasLb (fun x => x)
#expect_true "bound is an upper bound of x ↦ min x 3" unfolding L11.bound :
  ∀ x : ℝ, min x 3 ≤ L11.bound
#expect_true "root² - 4·root + 4 = 0" unfolding L11.root :
  L11.root ^ 2 - 4 * L11.root + 4 = 0
#expect_false "some real number is both positive and negative" :
  ∃ x : ℝ, x > 0 ∧ x < 0
#expect_true "x ↦ x takes both signs" unfolding L11.TakesBothSigns :
  L11.TakesBothSigns (fun x => x)
#expect_false "x ↦ x² + 1 takes both signs" unfolding L11.TakesBothSigns :
  L11.TakesBothSigns (fun x => x ^ 2 + 1)

#level_report
