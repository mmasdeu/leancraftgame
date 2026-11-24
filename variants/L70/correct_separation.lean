def IsClopen {n : Nat} (T : Family n) (U : Finset (Fin n)) : Prop := U ∈ T ∧ Uᶜ ∈ T

-- no two disjoint nonempty open sets cover the space
def IsConnected {n : Nat} (T : Family n) : Prop :=
  ¬ ∃ U ∈ T, ∃ V ∈ T, U.Nonempty ∧ V.Nonempty ∧ U ∩ V = ∅ ∧ U ∪ V = Finset.univ

def split : Family 3 := {∅, {2}, {0, 1}, {0, 1, 2}}
