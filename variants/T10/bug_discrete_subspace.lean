def subspaceTopology {α : Type*} (τ : TopologicalSpace α) (A : Set α) :
    TopologicalSpace A :=
  ⊤

def SubspaceOpen {α : Type*} (τ : TopologicalSpace α) (A : Set α) (s : Set A) : Prop :=
  ∃ U : Set α, @IsOpen α τ U ∧ s = (fun x : A => x.1) ⁻¹' U

def chosenSubset : Set Bool := {true}

def openNotClosedSet : Set Bool := {true}
