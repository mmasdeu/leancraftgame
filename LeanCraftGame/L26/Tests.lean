/- Hidden test battery for Level Spot the bug: limits. -/
import LeanCraftGame.Referee
import LeanCraftGame.L29.Player

namespace L29Ref
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
end L29Ref

#no_sorry L29.seqA
#no_sorry L29.limA
#no_sorry L29.seqB
#no_sorry L29.limB
#level_start "Spot the bug: limits"

#expect_true "seqA converges to limA" unfolding L29Ref.ConvergesTo L29.seqA L29.limA :
  L29Ref.ConvergesTo L29.seqA L29.limA
#expect_true "Alice's ConvergesA rejects seqA and limA" unfolding L29Ref.ConvergesA L29.seqA L29.limA :
  ¬ (L29Ref.ConvergesA L29.seqA L29.limA)
#expect_true "seqB does not converge to limB" unfolding L29Ref.ConvergesTo L29.seqB L29.limB :
  ¬ (L29Ref.ConvergesTo L29.seqB L29.limB)
#expect_true "Bob's ConvergesB accepts seqB and limB" unfolding L29Ref.ConvergesB L29.seqB L29.limB :
  L29Ref.ConvergesB L29.seqB L29.limB

#level_report
