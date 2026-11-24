/- Hidden test battery for T6 Closed sets and closure. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Basic
import LeanCraftGame.T6.Player

open LeanCraftGame.Topology

#no_sorry T6.MyClosed
#no_sorry T6.MyInterior
#no_sorry T6.MyClosure
#no_sorry T6.Dense
#no_sorry T6.Clopen
#level_start "Closed sets and closure"

#expect_true "closed means open complement" unfolding T6.MyClosed :
  ∀ {α : Type*} (τ : MyTopology α) (s : Set α), T6.MyClosed τ s → τ.IsOpen sᶜ

#expect_true "false is closed in Sierpinski" unfolding T6.MyClosed particularPoint :
  T6.MyClosed sierpinski {false}

#expect_true "interior contains every open subset" unfolding T6.MyInterior :
  ∀ {α : Type*} (τ : MyTopology α) (s U : Set α), τ.IsOpen U → U ⊆ s → U ⊆ T6.MyInterior τ s

#expect_true "closure contains the original set" unfolding T6.MyClosure T6.MyClosed :
  ∀ {α : Type*} (τ : MyTopology α) (s : Set α), s ⊆ T6.MyClosure τ s

#expect_true "dense means closure universal" unfolding T6.Dense :
  ∀ {α : Type*} (τ : MyTopology α) (s : Set α), T6.Dense τ s ↔ T6.MyClosure τ s = Set.univ

#expect_true "clopen requires open and closed" unfolding T6.Clopen :
  ∀ {α : Type*} (τ : MyTopology α) (s : Set α), T6.Clopen τ s → τ.IsOpen s ∧ T6.MyClosed τ s

#level_report
