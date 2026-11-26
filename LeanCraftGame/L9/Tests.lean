/- Hidden test battery for Level 9: ∃. -/
import LeanCraftGame.Referee
import LeanCraftGame.L9.Player

#no_sorry L9.FnHasUb
#no_sorry L9.FnHasLb
#no_sorry L9.bound
#no_sorry L9.root
#no_sorry L9.TakesBothSigns
#level_start "∃"

#expect_true "x ↦ min x 3 has an upper bound" unfolding L9.FnHasUb L9.FnUb :
  L9.FnHasUb (fun x => min x 3)
#expect_false "x ↦ x has an upper bound" unfolding L9.FnHasUb L9.FnUb :
  L9.FnHasUb (fun x => x)
#expect_true "x ↦ x² has a lower bound" unfolding L9.FnHasLb :
  L9.FnHasLb (fun x => x ^ 2)
#expect_false "x ↦ x has a lower bound" unfolding L9.FnHasLb :
  L9.FnHasLb (fun x => x)
#expect_true "bound is an upper bound of x ↦ min x 3" unfolding L9.bound :
  ∀ x : ℝ, min x 3 ≤ L9.bound
#expect_true "root² - 4·root + 4 = 0" unfolding L9.root :
  L9.root ^ 2 - 4 * L9.root + 4 = 0
#expect_false "some real number is both positive and negative" :
  ∃ x : ℝ, x > 0 ∧ x < 0
#expect_true "x ↦ x takes both signs" unfolding L9.TakesBothSigns :
  L9.TakesBothSigns (fun x => x)
#expect_false "x ↦ x² + 1 takes both signs" unfolding L9.TakesBothSigns :
  L9.TakesBothSigns (fun x => x ^ 2 + 1)

#level_report
