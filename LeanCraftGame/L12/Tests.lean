/- Hidden test battery for Level 10: ¬ and the order of quantifiers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L12.Player

#no_sorry L12.NotFnUb
#no_sorry L12.NoUpperBound
#no_sorry L12.NotMonotone
#no_sorry L12.BoundedSeq
#level_start "¬ and the order of quantifiers"

#expect_equiv "NotFnUb f a means ¬ FnUb f a" unfolding L12.NotFnUb L12.FnUb :
  ∀ f a, L12.NotFnUb f a ↔ ∃ x, a < f x
#expect_equiv "NoUpperBound f means ¬ FnHasUb f" unfolding L12.NoUpperBound :
  ∀ f, L12.NoUpperBound f ↔ ∀ a, ∃ x, a < f x
#expect_equiv "NotMonotone f means ¬ Monotone f" unfolding L12.NotMonotone :
  ∀ f : ℝ → ℝ, L12.NotMonotone f ↔ ∃ a b, a ≤ b ∧ f b < f a
#expect_true "x ↦ x has no upper bound" unfolding L12.NoUpperBound :
  L12.NoUpperBound (fun x => x)
#expect_false "x ↦ min x 0 has no upper bound" unfolding L12.NoUpperBound :
  L12.NoUpperBound (fun x => min x 0)
#expect_true "x ↦ -x is not monotone" unfolding L12.NotMonotone :
  L12.NotMonotone (fun x => -x)
#expect_false "x ↦ 2x is not monotone" unfolding L12.NotMonotone :
  L12.NotMonotone (fun x => 2 * x)
#expect_true "∀ n, ∃ M, n ≤ M holds in ℕ" :
  ∀ n : ℕ, ∃ M : ℕ, n ≤ M
#expect_true "the constant sequence 5 is bounded" unfolding L12.BoundedSeq :
  L12.BoundedSeq (fun _ => 5)
#expect_false "the sequence 0, 1, 2, 3, … is bounded" unfolding L12.BoundedSeq :
  L12.BoundedSeq (fun n => n)

#level_report
