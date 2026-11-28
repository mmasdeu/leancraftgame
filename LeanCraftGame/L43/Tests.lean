/- Hidden test battery for Level 43: Filters. -/
import LeanCraftGame.Referee
import LeanCraftGame.L43.Player

open Filter Topology

#no_sorry L43.EventuallyPos
#no_sorry L43.OftenZero
#no_sorry L43.ConvTo
#no_sorry L43.ToInfinity
#no_sorry L43.ContAt
#no_sorry L43.q1
#no_sorry L43.q2
#no_sorry L43.q3
#level_start "Filters"

#expect_choice "Question 1: the negation of `∀ᶠ n in atTop, P n`" : L43.q1 = 1
#expect_choice "Question 2: in `Tendsto f l₁ l₂`, the filter on the inputs of `f`" : L43.q2 = 1
#expect_choice "Question 3: `Tendsto u ⊥ (𝓝 0)` for every sequence `u`?" : L43.q3 = true

#expect_equiv "EventuallyPos says: eventually 0 < u n" unfolding L43.EventuallyPos :
  ∀ u, L43.EventuallyPos u ↔ ∀ᶠ n in atTop, 0 < u n
#expect_equiv "OftenZero says: frequently u n = 0" unfolding L43.OftenZero :
  ∀ u, L43.OftenZero u ↔ ∃ᶠ n in atTop, u n = 0
#expect_equiv "ConvTo says: u converges to a" unfolding L43.ConvTo :
  ∀ u a, L43.ConvTo u a ↔ Tendsto u atTop (𝓝 a)
#expect_equiv "ToInfinity says: u tends to infinity" unfolding L43.ToInfinity :
  ∀ u, L43.ToInfinity u ↔ Tendsto u atTop atTop
#expect_equiv "ContAt says: f is continuous at x" unfolding L43.ContAt :
  ∀ f x, L43.ContAt f x ↔ Tendsto f (𝓝 x) (𝓝 (f x))

#level_report
