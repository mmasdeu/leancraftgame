/- Hidden test battery for Level Spot the bug: limits. -/
import LeanCraftGame.Referee
import LeanCraftGame.L43.Player

namespace L43Ref
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
end L43Ref

#no_sorry L43.seqA
#no_sorry L43.limA
#no_sorry L43.seqB
#no_sorry L43.limB
#level_start "Spot the bug: limits"

#expect_true "seqA converges to limA" unfolding L43Ref.ConvergesTo L43.seqA L43.limA :
  L43Ref.ConvergesTo L43.seqA L43.limA
#expect_true "Alice's ConvergesA rejects seqA and limA" unfolding L43Ref.ConvergesA L43.seqA L43.limA :
  ¬ (L43Ref.ConvergesA L43.seqA L43.limA)
#expect_true "seqB does not converge to limB" unfolding L43Ref.ConvergesTo L43.seqB L43.limB :
  ¬ (L43Ref.ConvergesTo L43.seqB L43.limB)
#expect_true "Bob's ConvergesB accepts seqB and limB" unfolding L43Ref.ConvergesB L43.seqB L43.limB :
  L43Ref.ConvergesB L43.seqB L43.limB

#level_report
