/- Hidden test battery for Level Spot the bug: quantifiers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L22.Player

namespace L22Ref
def HasPositiveRoot (f : ℕ → ℕ) : Prop := ∃ n, n > 0 → f n = 0
def EventuallyZero (u : ℕ → ℕ) : Prop := ∀ N, ∃ n ≥ N, u n = 0
def Unbounded (u : ℕ → ℕ) : Prop := ∃ M, ∀ n, M ≤ u n
end L22Ref

#no_sorry L22.noRoot
#no_sorry L22.notEventuallyZero
#no_sorry L22.bounded
#level_start "Spot the bug: quantifiers"

#expect_true "HasPositiveRoot accepts your function" unfolding L22Ref.HasPositiveRoot L22.noRoot :
  L22Ref.HasPositiveRoot L22.noRoot
#expect_true "your function has no root other than 0" unfolding L22.noRoot :
  ¬ (∃ n > 0, L22.noRoot n = 0)
#expect_true "EventuallyZero accepts your sequence" unfolding L22Ref.EventuallyZero L22.notEventuallyZero :
  L22Ref.EventuallyZero L22.notEventuallyZero
#expect_true "your sequence is not eventually 0" unfolding L22.notEventuallyZero :
  ¬ (∃ N, ∀ n ≥ N, L22.notEventuallyZero n = 0)
#expect_true "Unbounded accepts your sequence" unfolding L22Ref.Unbounded L22.bounded :
  L22Ref.Unbounded L22.bounded
#expect_true "your sequence is bounded" unfolding L22.bounded :
  ¬ (∀ M, ∃ n, M ≤ L22.bounded n)

#level_report
