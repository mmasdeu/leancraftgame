-- closed under intersections instead of locally: rejects good bases
def IsBasis {n : Nat} (B : Family n) : Prop :=
  (∀ x, ∃ U ∈ B, x ∈ U) ∧ ∀ U ∈ B, ∀ V ∈ B, U ∩ V ∈ B

def generated {n : Nat} (B : Family n) : Family n :=
  Finset.univ.powerset.filter (fun A => ∀ x ∈ A, ∃ U ∈ B, x ∈ U ∧ U ⊆ A)

def subbasic : Family 3 := {{0, 1}, {1, 2}}
