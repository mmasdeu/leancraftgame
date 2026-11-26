def IsT1 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, (x ∈ U ∧ y ∉ U) ∨ (y ∈ U ∧ x ∉ U)

def IsT2 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, ∃ V ∈ T, x ∈ U ∧ y ∈ V ∧ U ∩ V = ∅

def noSubcover : ℕ → Set ℕ := fun i => {i}

def q1 : Bool := true
def q2 : Fin 3 := 2
