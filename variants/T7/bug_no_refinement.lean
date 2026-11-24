def CoversBy {α : Type*} (B : Set (Set α)) : Prop := ∀ x, ∃ U ∈ B, x ∈ U

def IntersectionRefines {α : Type*} (B : Set (Set α)) : Prop :=
  T7.CoversBy B

def GeneratedOpen {α : Type*} (B : Set (Set α)) (s : Set α) : Prop :=
  ∃ C : Set (Set α), C ⊆ B ∧ s = ⋃₀ C

def twoPointBasis : Set (Set Bool) := {{true}, {false}}
