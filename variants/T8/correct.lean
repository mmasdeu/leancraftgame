open LeanCraftGame.Topology

def MyContinuous {α β : Type*} (τs : MyTopology α) (τt : MyTopology β)
    (f : α → β) : Prop :=
  ∀ s, τt.IsOpen s → τs.IsOpen (f ⁻¹' s)
