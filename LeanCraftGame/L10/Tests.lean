/- Hidden test battery for Level 10: ¬ and the order of quantifiers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L10.Player

#no_sorry L10.NotFnUb
#no_sorry L10.NoUpperBound
#no_sorry L10.NotMonotone
#no_sorry L10.BoundedSeq
#level_start "¬ and the order of quantifiers"

#expect_equiv "NotFnUb f a means ¬ FnUb f a" unfolding L10.NotFnUb L10.FnUb :
  ∀ f a, L10.NotFnUb f a ↔ ∃ x, a < f x
#expect_equiv "NoUpperBound f means ¬ FnHasUb f" unfolding L10.NoUpperBound :
  ∀ f, L10.NoUpperBound f ↔ ∀ a, ∃ x, a < f x
#expect_equiv "NotMonotone f means ¬ Monotone f" unfolding L10.NotMonotone :
  ∀ f : ℝ → ℝ, L10.NotMonotone f ↔ ∃ a b, a ≤ b ∧ f b < f a
#expect_true "x ↦ x has no upper bound" unfolding L10.NoUpperBound :
  L10.NoUpperBound (fun x => x)
#expect_false "x ↦ min x 0 has no upper bound" unfolding L10.NoUpperBound :
  L10.NoUpperBound (fun x => min x 0)
#expect_true "x ↦ -x is not monotone" unfolding L10.NotMonotone :
  L10.NotMonotone (fun x => -x)
#expect_false "x ↦ 2x is not monotone" unfolding L10.NotMonotone :
  L10.NotMonotone (fun x => 2 * x)
#expect_true "∀ n, ∃ M, n ≤ M holds in ℕ" :
  ∀ n : ℕ, ∃ M : ℕ, n ≤ M
#expect_true "the constant sequence 5 is bounded" unfolding L10.BoundedSeq :
  L10.BoundedSeq (fun _ => 5)
#expect_false "the sequence 0, 1, 2, 3, … is bounded" unfolding L10.BoundedSeq :
  L10.BoundedSeq (fun n => n)

#level_report
