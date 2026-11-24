open LeanCraftGame.Topology

def MyClosed {α : Type*} (τ : MyTopology α) (s : Set α) : Prop := τ.IsOpen s

def MyInterior {α : Type*} (τ : MyTopology α) (s : Set α) : Set α :=
  ⋃₀ {U | τ.IsOpen U ∧ U ⊆ s}

def MyClosure {α : Type*} (τ : MyTopology α) (s : Set α) : Set α :=
  ⋂₀ {C | MyClosed τ C ∧ s ⊆ C}

def Dense {α : Type*} (τ : MyTopology α) (s : Set α) : Prop := MyClosure τ s = Set.univ

def Clopen {α : Type*} (τ : MyTopology α) (s : Set α) : Prop := τ.IsOpen s ∧ MyClosed τ s
