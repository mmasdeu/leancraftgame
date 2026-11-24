def IsBasis {n : Nat} (B : Family n) : Prop :=
  (∀ x, ∃ U ∈ B, x ∈ U) ∧ ∀ U ∈ B, ∀ V ∈ B, ∀ x ∈ U ∩ V, ∃ W ∈ B, x ∈ W ∧ W ⊆ U ∩ V

-- forgot "inside A"
def generated {n : Nat} (B : Family n) : Family n :=
  Finset.univ.powerset.filter (fun A => ∀ x ∈ A, ∃ U ∈ B, x ∈ U)

def subbasic : Family 3 := {{0, 1}, {1, 2}}
