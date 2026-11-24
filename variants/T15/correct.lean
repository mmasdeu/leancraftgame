open LeanCraftGame.Topology

def IsNeighbourhood {α : Type*} (τ : MyTopology α) (x : α) (s : Set α) : Prop :=
  ∃ U, τ.IsOpen U ∧ x ∈ U ∧ U ⊆ s

def MyConverges {α : Type*} (τ : MyTopology α) (u : ℕ → α) (x : α) : Prop :=
  ∀ s, IsNeighbourhood τ x s → ∃ N, ∀ n ≥ N, u n ∈ s

def MathlibConverges {α : Type*} [TopologicalSpace α] (u : ℕ → α) (x : α) : Prop :=
  Filter.Tendsto u Filter.atTop (nhds x)

def NeighbourhoodFilter {α : Type*} [TopologicalSpace α] (x : α) : Filter α := nhds x

def dualLimitSequence : ℕ → Bool := fun _ => true
