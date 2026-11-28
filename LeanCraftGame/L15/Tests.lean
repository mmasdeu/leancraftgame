/- Hidden test battery for Level 14: Spot the bug: logic. -/
import LeanCraftGame.Referee
import LeanCraftGame.L15.Player

namespace L14Ref
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
def SomePositive (u : ℕ → ℝ) : Prop := ∃ n, n > 0 → u n > 0
def BoundedAbove (f : ℝ → ℝ) : Prop := ∀ x, ∃ M, f x ≤ M
end L14Ref

#no_sorry L15.seqA
#no_sorry L15.limA
#no_sorry L15.seqB
#no_sorry L15.limB
#no_sorry L15.seqC
#no_sorry L15.funD
#level_start "Spot the bug: logic"

#expect_true "seqA converges to limA" unfolding L14Ref.ConvergesTo L15.seqA L15.limA :
  L14Ref.ConvergesTo L15.seqA L15.limA
#expect_true "Sam's ConvergesA rejects seqA and limA" unfolding L14Ref.ConvergesA L15.seqA L15.limA :
  ¬ L14Ref.ConvergesA L15.seqA L15.limA
#expect_true "seqB does not converge to limB" unfolding L14Ref.ConvergesTo L15.seqB L15.limB :
  ¬ L14Ref.ConvergesTo L15.seqB L15.limB
#expect_true "Sam's ConvergesB accepts seqB and limB" unfolding L14Ref.ConvergesB L15.seqB L15.limB :
  L14Ref.ConvergesB L15.seqB L15.limB
#expect_true "no term of seqC is positive" unfolding L15.seqC :
  ∀ n, L15.seqC n ≤ 0
#expect_true "Sam's SomePositive accepts seqC" unfolding L14Ref.SomePositive L15.seqC :
  L14Ref.SomePositive L15.seqC
#expect_true "funD is not bounded above" unfolding L15.funD :
  ¬ ∃ M, ∀ x, L15.funD x ≤ M
#expect_true "Sam's BoundedAbove accepts funD" unfolding L14Ref.BoundedAbove L15.funD :
  L14Ref.BoundedAbove L15.funD

#level_report
