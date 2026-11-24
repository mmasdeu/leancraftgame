/- Hidden test battery for T12 Compactness. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Maps
import LeanCraftGame.T12.Player

open LeanCraftGame.Topology

#no_sorry T12.MyCompact
#level_start "Compactness"

#expect_true "compactness returns a finite subcover" unfolding T12.MyCompact :
  ∀ {α : Type*} (τ : MyTopology α), T12.MyCompact τ →
    ∀ C : Set (Set α), (∀ s ∈ C, τ.IsOpen s) → (⋃₀ C) = Set.univ →
      ∃ F : Finset (Set α), (↑F : Set (Set α)) ⊆ C ∧ (⋃₀ (↑F : Set (Set α))) = Set.univ

#expect_true "finite covers are enough to state compactness" unfolding T12.MyCompact :
  ∀ {α : Type*} (τ : MyTopology α) (C : Set (Set α)),
    T12.MyCompact τ → (∀ s ∈ C, τ.IsOpen s) → (⋃₀ C) = Set.univ →
      ∃ F : Finset (Set α), (↑F : Set (Set α)) ⊆ C ∧ (⋃₀ (↑F : Set (Set α))) = Set.univ

#level_report
