open LeanCraftGame.Topology

def MyCompact {α : Type*} (τ : MyTopology α) : Prop :=
  ∀ C : Set (Set α), (∀ s ∈ C, τ.IsOpen s) → (⋃₀ C) = Set.univ →
    ∃ U ∈ C, U = Set.univ
