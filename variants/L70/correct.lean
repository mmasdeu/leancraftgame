def IsClopen {n : Nat} (T : Family n) (U : Finset (Fin n)) : Prop := U ∈ T ∧ Uᶜ ∈ T

def IsConnected {n : Nat} (T : Family n) : Prop :=
  ∀ U, IsClopen T U → U = ∅ ∨ U = Finset.univ

def split : Family 3 := {∅, {0}, {1, 2}, Finset.univ}
