/- Hidden test battery for Level Be the referee. -/
import LeanCraftGame.Referee
import LeanCraftGame.L27.Player

open L27

namespace L27Ref
def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n
-- the mutants: wrong definitions that players write by mistake
def MutUnbounded (u : ℕ → ℕ) : Prop := ∀ M, ∃ n, M ≤ u n
def MutStrictMono (u : ℕ → ℕ) : Prop := ∀ n, u n < u (n + 1)
def MutSwap (u : ℕ → ℕ) : Prop := ∃ N, ∀ M, ∀ n ≥ N, M ≤ u n
def MutMonoUnbounded (u : ℕ → ℕ) : Prop := (∀ n, u n ≤ u (n + 1)) ∧ ∀ M, ∃ n, M ≤ u n
def MutAboveId (u : ℕ → ℕ) : Prop := ∀ n, n ≤ u n
def MutEventuallyPos (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, 1 ≤ u n
end L27Ref

#no_sorry good₁
#no_sorry good₂
#no_sorry bad₁
#no_sorry bad₂
#level_start "Be the referee"

-- your labels must be honest
#expect_true "good₁ tends to infinity" unfolding L27Ref.TendsToInfinity good₁ :
  L27Ref.TendsToInfinity good₁
#expect_true "good₂ tends to infinity" unfolding L27Ref.TendsToInfinity good₂ :
  L27Ref.TendsToInfinity good₂
#expect_false "bad₁ tends to infinity" unfolding L27Ref.TendsToInfinity bad₁ :
  L27Ref.TendsToInfinity bad₁
#expect_false "bad₂ tends to infinity" unfolding L27Ref.TendsToInfinity bad₂ :
  L27Ref.TendsToInfinity bad₂

-- the mutants: each one must get at least one of your four sequences wrong
#expect_caught "mutant `∃ N, ∀ M, ∀ n ≥ N, M ≤ u n` (quantifiers swapped) is caught" unfolding L27Ref.MutSwap good₁ good₂ bad₁ bad₂ :
  L27Ref.MutSwap good₁ ∧ L27Ref.MutSwap good₂ ∧ ¬ L27Ref.MutSwap bad₁ ∧ ¬ L27Ref.MutSwap bad₂
#expect_caught "mutant `∀ M, ∃ n, M ≤ u n` (merely unbounded) is caught" unfolding L27Ref.MutUnbounded good₁ good₂ bad₁ bad₂ :
  L27Ref.MutUnbounded good₁ ∧ L27Ref.MutUnbounded good₂ ∧ ¬ L27Ref.MutUnbounded bad₁ ∧ ¬ L27Ref.MutUnbounded bad₂
#expect_caught "mutant `∀ n, u n < u (n + 1)` (strictly increasing) is caught" unfolding L27Ref.MutStrictMono good₁ good₂ bad₁ bad₂ :
  L27Ref.MutStrictMono good₁ ∧ L27Ref.MutStrictMono good₂ ∧ ¬ L27Ref.MutStrictMono bad₁ ∧ ¬ L27Ref.MutStrictMono bad₂
#expect_caught "mutant `(∀ n, u n ≤ u (n + 1)) ∧ ∀ M, ∃ n, M ≤ u n` (monotone and unbounded) is caught" unfolding L27Ref.MutMonoUnbounded good₁ good₂ bad₁ bad₂ :
  L27Ref.MutMonoUnbounded good₁ ∧ L27Ref.MutMonoUnbounded good₂ ∧ ¬ L27Ref.MutMonoUnbounded bad₁ ∧ ¬ L27Ref.MutMonoUnbounded bad₂
#expect_caught "mutant `∀ n, n ≤ u n` (at least the identity) is caught" unfolding L27Ref.MutAboveId good₁ good₂ bad₁ bad₂ :
  L27Ref.MutAboveId good₁ ∧ L27Ref.MutAboveId good₂ ∧ ¬ L27Ref.MutAboveId bad₁ ∧ ¬ L27Ref.MutAboveId bad₂
#expect_caught "mutant `∃ N, ∀ n ≥ N, 1 ≤ u n` (eventually positive) is caught" unfolding L27Ref.MutEventuallyPos good₁ good₂ bad₁ bad₂ :
  L27Ref.MutEventuallyPos good₁ ∧ L27Ref.MutEventuallyPos good₂ ∧ ¬ L27Ref.MutEventuallyPos bad₁ ∧ ¬ L27Ref.MutEventuallyPos bad₂

#level_report
