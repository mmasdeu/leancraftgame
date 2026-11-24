-- "no two disjoint nonempty open sets": forgot that they must cover the space
def IsClopen {n : Nat} (T : Family n) (U : Finset (Fin n)) : Prop := U ∈ T ∧ Uᶜ ∈ T

def IsConnected {n : Nat} (T : Family n) : Prop :=
  ¬ ∃ U ∈ T, ∃ V ∈ T, U.Nonempty ∧ V.Nonempty ∧ U ∩ V = ∅

def split : Family 3 := {∅, {0}, {1, 2}, Finset.univ}
