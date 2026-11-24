open LeanCraftGame.Topology

def MyConnected {α : Type*} (τ : MyTopology α) : Prop :=
  ∀ U V : Set α, τ.IsOpen U → τ.IsOpen V → U ∪ V = Set.univ → U ∩ V = ∅ → U = ∅ ∨ V = ∅
