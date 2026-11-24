/- Hidden test battery for T8 Continuous maps. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Maps
import LeanCraftGame.T8.Player

#no_sorry T8.MyContinuous
#no_sorry T8.MyOpenMap
#no_sorry T8.continuousNotOpenMap
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

#expect_true "open maps use direct images" unfolding T8.MyOpenMap :
  ∀ {α β : Type*} (τs : LeanCraftGame.Topology.MyTopology α)
    (τt : LeanCraftGame.Topology.MyTopology β) (f : α → β),
    T8.MyOpenMap τs τt f → ∀ s, τs.IsOpen s → τt.IsOpen (f '' s)

#expect_true "continuous not open map is constant false" unfolding T8.continuousNotOpenMap :
  ∀ x, T8.continuousNotOpenMap x = false

#level_report
