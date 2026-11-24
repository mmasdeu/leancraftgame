def MyDisjoint {α : Type*} (s t : Set α) : Prop :=
  ∀ x, x ∈ s → x ∈ t → False
