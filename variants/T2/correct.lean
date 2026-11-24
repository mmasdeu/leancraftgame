def Family (α : Type*) (ι : Type*) : Type _ := ι → Set α

def ClosedUnderUnions {α : Type*} (C : Set (Set α)) : Prop :=
  ∀ D : Set (Set α), D ⊆ C → ⋃₀ D ∈ C

def ClosedUnderBinaryIntersections {α : Type*} (C : Set (Set α)) : Prop :=
  ∀ s ∈ C, ∀ t ∈ C, s ∩ t ∈ C

def FiniteButNotUnionClosed : List (Finset (Fin 3)) := [∅, {0}, {1}, Finset.univ]
