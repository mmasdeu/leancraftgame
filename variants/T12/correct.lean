open LeanCraftGame.Topology

def MyCompact {α : Type*} (τ : MyTopology α) : Prop :=
  ∀ C : Set (Set α), (∀ s ∈ C, τ.IsOpen s) → (⋃₀ C) = Set.univ →
    ∃ F : Finset (Set α), (↑F : Set (Set α)) ⊆ C ∧ (⋃₀ (↑F : Set (Set α))) = Set.univ
