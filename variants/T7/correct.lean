def CoversBy {α : Type*} (B : Set (Set α)) : Prop := ∀ x, ∃ U ∈ B, x ∈ U

def IntersectionRefines {α : Type*} (B : Set (Set α)) : Prop :=
  ∀ U ∈ B, ∀ V ∈ B, ∀ x ∈ U ∩ V, ∃ W ∈ B, x ∈ W ∧ W ⊆ U ∩ V

def GeneratedOpen {α : Type*} (B : Set (Set α)) (s : Set α) : Prop :=
  ∃ C : Set (Set α), C ⊆ B ∧ s = ⋃₀ C

def twoPointBasis : Set (Set Bool) := {{true}, {false}}
