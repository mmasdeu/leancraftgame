/- Hidden test battery for T13 Connectedness. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Maps
import LeanCraftGame.T13.Player

open LeanCraftGame.Topology

#no_sorry T13.MyConnected
#level_start "Connectedness"

#expect_true "connectedness rules out separations" unfolding T13.MyConnected :
  ∀ {α : Type*} (τ : MyTopology α), T13.MyConnected τ →
    ∀ U V : Set α, τ.IsOpen U → τ.IsOpen V → U ∪ V = Set.univ → U ∩ V = ∅ → U = ∅ ∨ V = ∅

#expect_true "connectedness applies to arbitrary open pairs" unfolding T13.MyConnected :
  ∀ {α : Type*} (τ : MyTopology α) (U V : Set α),
    T13.MyConnected τ → τ.IsOpen U → τ.IsOpen V → U ∪ V = Set.univ → U ∩ V = ∅ → U = ∅ ∨ V = ∅

#level_report
