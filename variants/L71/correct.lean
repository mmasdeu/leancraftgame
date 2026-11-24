def IsT0 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, (x ∈ U ∧ y ∉ U) ∨ (y ∈ U ∧ x ∉ U)

def IsT1 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, x ∈ U ∧ y ∉ U

def IsT2 {n : Nat} (T : Family n) : Prop :=
  ∀ x y : Fin n, x ≠ y → ∃ U ∈ T, ∃ V ∈ T, x ∈ U ∧ y ∈ V ∧ U ∩ V = ∅

def kolmo : Family 3 := Top.particularPoint 3 0

def q1 : Bool := false
