def productTopology {α β : Type*} (τs : TopologicalSpace α) (τt : TopologicalSpace β) :
    TopologicalSpace (α × β) :=
  TopologicalSpace.induced Prod.fst τs ⊓ TopologicalSpace.induced Prod.snd τt

def Rectangle {α β : Type*} (U : Set α) (V : Set β) : Set (α × β) := U ×ˢ V

def Cylinder {ι α : Type*} (i : ι) (U : Set α) : Set (ι → α) := {f | ∀ i, f i ∈ U}

def allTrue : Set (Nat → Bool) := {f | ∀ n, f n = true}
