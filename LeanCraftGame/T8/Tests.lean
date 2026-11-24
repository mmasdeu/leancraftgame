/- Hidden test battery for T8 Continuous maps. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Maps
import LeanCraftGame.T8.Player

#no_sorry T8.MyContinuous
#level_start "Continuous maps"

#expect_true "the identity map is continuous" unfolding T8.MyContinuous :
  ∀ {α : Type*} (τ : LeanCraftGame.Topology.MyTopology α),
    T8.MyContinuous τ τ id

#expect_true "continuity uses inverse images" unfolding T8.MyContinuous :
  ∀ {α β : Type*} (τs : LeanCraftGame.Topology.MyTopology α)
    (τt : LeanCraftGame.Topology.MyTopology β) (f : α → β) (s : Set β),
    T8.MyContinuous τs τt f → τt.IsOpen s → τs.IsOpen (f ⁻¹' s)

#expect_true "discrete to indiscrete identity is continuous" unfolding T8.MyContinuous LeanCraftGame.Topology.discrete LeanCraftGame.Topology.indiscrete :
  T8.MyContinuous (LeanCraftGame.Topology.discrete Bool)
    (LeanCraftGame.Topology.indiscrete Bool) id

#level_report
