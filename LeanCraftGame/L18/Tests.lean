/- Hidden test battery for Level 17: Injective, surjective, inverses. -/
import LeanCraftGame.Referee
import LeanCraftGame.L18.Player

open L18

#no_sorry Inj
#no_sorry Surj
#no_sorry pred'
#no_sorry q1
#no_sorry q2
#no_sorry q3
#level_start "Injective, surjective, inverses"

#expect_true "Inj (n + 1)" unfolding Inj : Inj (fun n => n + 1)
#expect_false "Inj (n - 1)" unfolding Inj : Inj (fun n => n - 1)
#expect_true "Inj (2 n)" unfolding Inj : Inj (fun n => 2 * n)
#expect_false "Inj of a constant function" unfolding Inj : Inj (fun _ => 0)
#expect_false "Surj (n + 1)" unfolding Surj : Surj (fun n => n + 1)
#expect_true "Surj (n - 1)" unfolding Surj : Surj (fun n => n - 1)
#expect_false "Surj (n % 3)" unfolding Surj : Surj (fun n => n % 3)
#expect_true "Surj of the identity" unfolding Surj : Surj (fun n => n)
#expect_true "pred' is a left inverse of n + 1" unfolding Function.LeftInverse pred' :
  Function.LeftInverse pred' (fun n => n + 1)
#expect_choice "Question 1: why `invFun` asks for `[Nonempty α]`" : q1 = 0
#expect_choice "Question 2: is `invFun f` always a left inverse of `f`?" : q2 = false
#expect_choice "Question 3: what `Set.InjOn f s` says" : q3 = 2

#level_report
