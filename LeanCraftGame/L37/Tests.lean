/- Hidden test battery for Level 43: Filters. -/
import LeanCraftGame.Referee
import LeanCraftGame.L37.Player

open Filter Topology

#no_sorry L37.EventuallyPos
#no_sorry L37.OftenZero
#no_sorry L37.ConvTo
#no_sorry L37.ToInfinity
#no_sorry L37.ContAt
#no_sorry L37.q1
#no_sorry L37.q2
#no_sorry L37.q3
#level_start "Filters"

#expect_choice "Question 1: the negation of `∀ᶠ n in atTop, P n`" : L37.q1 = 1
#expect_choice "Question 2: in `Tendsto f l₁ l₂`, the filter on the inputs of `f`" : L37.q2 = 1
#expect_choice "Question 3: `Tendsto u ⊥ (𝓝 0)` for every sequence `u`?" : L37.q3 = true

#expect_equiv "EventuallyPos says: eventually 0 < u n" unfolding L37.EventuallyPos :
  ∀ u, L37.EventuallyPos u ↔ ∀ᶠ n in atTop, 0 < u n
#expect_equiv "OftenZero says: frequently u n = 0" unfolding L37.OftenZero :
  ∀ u, L37.OftenZero u ↔ ∃ᶠ n in atTop, u n = 0
#expect_equiv "ConvTo says: u converges to a" unfolding L37.ConvTo :
  ∀ u a, L37.ConvTo u a ↔ Tendsto u atTop (𝓝 a)
#expect_equiv "ToInfinity says: u tends to infinity" unfolding L37.ToInfinity :
  ∀ u, L37.ToInfinity u ↔ Tendsto u atTop atTop
#expect_equiv "ContAt says: f is continuous at x" unfolding L37.ContAt :
  ∀ f x, L37.ContAt f x ↔ Tendsto f (𝓝 x) (𝓝 (f x))

#level_report
