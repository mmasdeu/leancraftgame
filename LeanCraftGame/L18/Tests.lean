/- Hidden test battery for Level Spot the bug: quantifiers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L18.Player

namespace L26Ref
def HasPositiveRoot (f : ℕ → ℕ) : Prop := ∃ n, n > 0 → f n = 0
def EventuallyZero (u : ℕ → ℕ) : Prop := ∀ N, ∃ n ≥ N, u n = 0
def Unbounded (u : ℕ → ℕ) : Prop := ∃ M, ∀ n, M ≤ u n
end L26Ref

#no_sorry L18.noRoot
#no_sorry L18.notEventuallyZero
#no_sorry L18.bounded
#level_start "Spot the bug: quantifiers"

#expect_true "HasPositiveRoot accepts your function" unfolding L26Ref.HasPositiveRoot L18.noRoot :
  L26Ref.HasPositiveRoot L18.noRoot
#expect_true "your function has no root other than 0" unfolding L18.noRoot :
  ¬ (∃ n > 0, L18.noRoot n = 0)
#expect_true "EventuallyZero accepts your sequence" unfolding L26Ref.EventuallyZero L18.notEventuallyZero :
  L26Ref.EventuallyZero L18.notEventuallyZero
#expect_true "your sequence is not eventually 0" unfolding L18.notEventuallyZero :
  ¬ (∃ N, ∀ n ≥ N, L18.notEventuallyZero n = 0)
#expect_true "Unbounded accepts your sequence" unfolding L26Ref.Unbounded L18.bounded :
  L26Ref.Unbounded L18.bounded
#expect_true "your sequence is bounded" unfolding L18.bounded :
  ¬ (∀ M, ∃ n, M ≤ L18.bounded n)

#level_report
