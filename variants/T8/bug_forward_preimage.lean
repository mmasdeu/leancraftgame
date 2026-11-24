open LeanCraftGame.Topology

def MyContinuous {α β : Type*} (τs : MyTopology α) (τt : MyTopology β)
    (f : α → β) : Prop :=
  ∀ s, τs.IsOpen s → τt.IsOpen (f ⁻¹' s)
