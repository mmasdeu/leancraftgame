/- Hidden test battery for Level Spot the bug: quantifiers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L26.Player

namespace L26Ref
def HasPositiveRoot (f : ℕ → ℕ) : Prop := ∃ n, n > 0 → f n = 0
def EventuallyZero (u : ℕ → ℕ) : Prop := ∀ N, ∃ n ≥ N, u n = 0
def Unbounded (u : ℕ → ℕ) : Prop := ∃ M, ∀ n, M ≤ u n
end L26Ref

#no_sorry L26.noRoot
#no_sorry L26.notEventuallyZero
#no_sorry L26.bounded
#level_start "Spot the bug: quantifiers"

#expect_true "HasPositiveRoot accepts your function" unfolding L26Ref.HasPositiveRoot L26.noRoot :
  L26Ref.HasPositiveRoot L26.noRoot
#expect_true "your function has no root other than 0" unfolding L26.noRoot :
  ¬ (∃ n > 0, L26.noRoot n = 0)
#expect_true "EventuallyZero accepts your sequence" unfolding L26Ref.EventuallyZero L26.notEventuallyZero :
  L26Ref.EventuallyZero L26.notEventuallyZero
#expect_true "your sequence is not eventually 0" unfolding L26.notEventuallyZero :
  ¬ (∃ N, ∀ n ≥ N, L26.notEventuallyZero n = 0)
#expect_true "Unbounded accepts your sequence" unfolding L26Ref.Unbounded L26.bounded :
  L26Ref.Unbounded L26.bounded
#expect_true "your sequence is bounded" unfolding L26.bounded :
  ¬ (∀ M, ∃ n, M ≤ L26.bounded n)

#level_report
