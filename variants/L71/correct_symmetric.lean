def IsT0 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, (∀ U ∈ T, x ∈ U ↔ y ∈ U) → x = y

def IsT1 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → (∃ U ∈ T, x ∈ U ∧ y ∉ U) ∧ (∃ V ∈ T, y ∈ V ∧ x ∉ V)

def IsT2 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, ∃ V ∈ T, x ∈ U ∧ y ∈ V ∧ Disjoint U V

def kolmo : Family 3 := {∅, {1}, {1, 2}, {0, 1}, Finset.univ}

def q1 : Bool := false
