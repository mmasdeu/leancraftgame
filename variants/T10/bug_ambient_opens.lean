def subspaceTopology {α : Type*} (τ : TopologicalSpace α) (A : Set α) :
    TopologicalSpace A :=
  TopologicalSpace.induced (fun x : A => x.1) τ

def SubspaceOpen {α : Type*} (τ : TopologicalSpace α) (A : Set α) (s : Set A) : Prop :=
  @IsOpen α τ ((fun x : A => x.1) '' s)

def chosenSubset : Set Bool := {true}

def openNotClosedSet : Set Bool := {true}
