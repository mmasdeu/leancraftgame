/- Hidden test battery for Level 14: Spot the bug: logic. -/
import LeanCraftGame.Referee
import LeanCraftGame.L14.Player

namespace L14Ref
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
def SomePositive (u : ℕ → ℝ) : Prop := ∃ n, n > 0 → u n > 0
def BoundedAbove (f : ℝ → ℝ) : Prop := ∀ x, ∃ M, f x ≤ M
end L14Ref

#no_sorry L14.seqA
#no_sorry L14.limA
#no_sorry L14.seqB
#no_sorry L14.limB
#no_sorry L14.seqC
#no_sorry L14.funD
#level_start "Spot the bug: logic"

#expect_true "seqA converges to limA" unfolding L14Ref.ConvergesTo L14.seqA L14.limA :
  L14Ref.ConvergesTo L14.seqA L14.limA
#expect_true "Alice's ConvergesA rejects seqA and limA" unfolding L14Ref.ConvergesA L14.seqA L14.limA :
  ¬ L14Ref.ConvergesA L14.seqA L14.limA
#expect_true "seqB does not converge to limB" unfolding L14Ref.ConvergesTo L14.seqB L14.limB :
  ¬ L14Ref.ConvergesTo L14.seqB L14.limB
#expect_true "Bob's ConvergesB accepts seqB and limB" unfolding L14Ref.ConvergesB L14.seqB L14.limB :
  L14Ref.ConvergesB L14.seqB L14.limB
#expect_true "no term of seqC is positive" unfolding L14.seqC :
  ∀ n, L14.seqC n ≤ 0
#expect_true "Carol's SomePositive accepts seqC" unfolding L14Ref.SomePositive L14.seqC :
  L14Ref.SomePositive L14.seqC
#expect_true "funD is not bounded above" unfolding L14.funD :
  ¬ ∃ M, ∀ x, L14.funD x ≤ M
#expect_true "Dan's BoundedAbove accepts funD" unfolding L14Ref.BoundedAbove L14.funD :
  L14Ref.BoundedAbove L14.funD

#level_report
