/- Hidden test battery for Level Spot the bug: limits. -/
import LeanCraftGame.Referee
import LeanCraftGame.L26.Player

namespace L29Ref
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
end L29Ref

#no_sorry L26.seqA
#no_sorry L26.limA
#no_sorry L26.seqB
#no_sorry L26.limB
#level_start "Spot the bug: limits"

#expect_true "seqA converges to limA" unfolding L29Ref.ConvergesTo L26.seqA L26.limA :
  L29Ref.ConvergesTo L26.seqA L26.limA
#expect_true "Alice's ConvergesA rejects seqA and limA" unfolding L29Ref.ConvergesA L26.seqA L26.limA :
  ¬ (L29Ref.ConvergesA L26.seqA L26.limA)
#expect_true "seqB does not converge to limB" unfolding L29Ref.ConvergesTo L26.seqB L26.limB :
  ¬ (L29Ref.ConvergesTo L26.seqB L26.limB)
#expect_true "Bob's ConvergesB accepts seqB and limB" unfolding L29Ref.ConvergesB L26.seqB L26.limB :
  L29Ref.ConvergesB L26.seqB L26.limB

#level_report
