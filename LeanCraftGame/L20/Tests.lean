/- Hidden test battery for Level Be the referee. -/
import LeanCraftGame.Referee
import LeanCraftGame.L20.Player

open L20

namespace L20Ref
def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n
-- the mutants: wrong definitions that players write by mistake. MutSwap, MutStrictMono,
-- MutMonoUnbounded and MutAboveId are stronger than TendsToInfinity; MutUnbounded and
-- MutEventuallyPos are weaker.
def MutUnbounded (u : ℕ → ℕ) : Prop := ∀ M, ∃ n, M ≤ u n
def MutStrictMono (u : ℕ → ℕ) : Prop := ∀ n, u n < u (n + 1)
def MutSwap (u : ℕ → ℕ) : Prop := ∃ N, ∀ M, ∀ n ≥ N, M ≤ u n
def MutMonoUnbounded (u : ℕ → ℕ) : Prop := (∀ n, u n ≤ u (n + 1)) ∧ ∀ M, ∃ n, M ≤ u n
def MutAboveId (u : ℕ → ℕ) : Prop := ∀ n, n ≤ u n
def MutEventuallyPos (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, 1 ≤ u n
end L20Ref

#no_sorry good₁
#no_sorry good₂
#no_sorry bad₁
#no_sorry bad₂
#level_start "Be the referee"

-- your labels must be honest
#expect_true "good₁ tends to infinity" unfolding L20Ref.TendsToInfinity good₁ :
  L20Ref.TendsToInfinity good₁
#expect_true "good₂ tends to infinity" unfolding L20Ref.TendsToInfinity good₂ :
  L20Ref.TendsToInfinity good₂
#expect_true "bad₁ does not tend to infinity" unfolding L20Ref.TendsToInfinity bad₁ :
  ¬ (L20Ref.TendsToInfinity bad₁)
#expect_true "bad₂ does not tend to infinity" unfolding L20Ref.TendsToInfinity bad₂ :
  ¬ (L20Ref.TendsToInfinity bad₂)

-- The mutants. Each one must get at least one of your four sequences wrong.
-- A mutant that is *stronger* than the right definition (it implies tending to
-- infinity) rejects every honest `bad` sequence, so only a `good` one can catch it:
-- it survives when it accepts both `good` sequences. A *weaker* mutant (implied by
-- tending to infinity) accepts every honest `good` sequence, so only a `bad` one
-- can catch it: it survives when it rejects both `bad` sequences. (The labels are
-- tested above.) Stating only the relevant half keeps the referee's search small.

#expect_caught "mutant `∃ N, ∀ M, ∀ n ≥ N, M ≤ u n` (quantifiers swapped) is caught" unfolding L20Ref.MutSwap good₁ good₂ :
  L20Ref.MutSwap good₁ ∧ L20Ref.MutSwap good₂
#expect_caught "mutant `∀ M, ∃ n, M ≤ u n` (merely unbounded) is caught" unfolding L20Ref.MutUnbounded bad₁ bad₂ :
  ¬ L20Ref.MutUnbounded bad₁ ∧ ¬ L20Ref.MutUnbounded bad₂
#expect_caught "mutant `∀ n, u n < u (n + 1)` (strictly increasing) is caught" unfolding L20Ref.MutStrictMono good₁ good₂ :
  L20Ref.MutStrictMono good₁ ∧ L20Ref.MutStrictMono good₂
#expect_caught "mutant `(∀ n, u n ≤ u (n + 1)) ∧ ∀ M, ∃ n, M ≤ u n` (monotone and unbounded) is caught" unfolding L20Ref.MutMonoUnbounded good₁ good₂ :
  L20Ref.MutMonoUnbounded good₁ ∧ L20Ref.MutMonoUnbounded good₂
#expect_caught "mutant `∀ n, n ≤ u n` (at least the identity) is caught" unfolding L20Ref.MutAboveId good₁ good₂ :
  L20Ref.MutAboveId good₁ ∧ L20Ref.MutAboveId good₂
#expect_caught "mutant `∃ N, ∀ n ≥ N, 1 ≤ u n` (eventually positive) is caught" unfolding L20Ref.MutEventuallyPos bad₁ bad₂ :
  ¬ L20Ref.MutEventuallyPos bad₁ ∧ ¬ L20Ref.MutEventuallyPos bad₂

#level_report
