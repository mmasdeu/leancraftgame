/- Hidden test battery for T15 Neighbourhoods, filters and convergence. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Maps
import LeanCraftGame.T15.Player

#no_sorry T15.IsNeighbourhood
#no_sorry T15.MyConverges
#no_sorry T15.MathlibConverges
#no_sorry T15.NeighbourhoodFilter
#no_sorry T15.dualLimitSequence
#level_start "Neighbourhoods, filters and convergence"

#expect_true "a neighbourhood contains an open neighbourhood" unfolding T15.IsNeighbourhood :
  ∀ {α : Type*} (τ : LeanCraftGame.Topology.MyTopology α) (x : α) (s : Set α),
    T15.IsNeighbourhood τ x s → ∃ U, τ.IsOpen U ∧ x ∈ U ∧ U ⊆ s

#expect_true "convergence is eventual membership in every neighbourhood" unfolding T15.MyConverges :
  ∀ {α : Type*} (τ : LeanCraftGame.Topology.MyTopology α) (u : ℕ → α) (x : α),
    T15.MyConverges τ u x → ∀ s, T15.IsNeighbourhood τ x s → ∃ N, ∀ n ≥ N, u n ∈ s

#expect_true "Mathlib convergence is Tendsto atTop nhds" unfolding T15.MathlibConverges :
  ∀ {α : Type*} [TopologicalSpace α] (u : ℕ → α) (x : α),
    T15.MathlibConverges u x ↔ Filter.Tendsto u Filter.atTop (nhds x)

#expect_true "neighbourhood filter is nhds" unfolding T15.NeighbourhoodFilter :
  ∀ {α : Type*} [TopologicalSpace α] (x : α), T15.NeighbourhoodFilter x = nhds x

#expect_true "the dual-limit sequence is constant true" unfolding T15.dualLimitSequence :
  ∀ n, T15.dualLimitSequence n = true

#level_report
