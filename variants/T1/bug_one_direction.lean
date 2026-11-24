def MyDisjoint {α : Type*} (s t : Set α) : Prop :=
  ∀ x, x ∈ s → x ∈ t → False

def IsCover {α : Type*} (s : Set α) (C : Set (Set α)) : Prop :=
  ∀ x ∈ s, ∃ U ∈ C, x ∈ U

def PreimagesPreserveOperations {α β : Type*} (f : α → β) : Prop :=
  ∀ s t : Set β, f ⁻¹' (s ∩ t) = (f ⁻¹' s) ∩ (f ⁻¹' t)

def DirectImagesPreserveIntersections {α β : Type*} (f : α → β) : Prop :=
  ∀ s t : Set α, f '' (s ∩ t) = (f '' s) ∩ (f '' t)

def counterexampleMap : Bool → Bool := fun _ => true
