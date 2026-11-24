def IsBasis {n : Nat} (B : Family n) : Prop :=
  (∀ x, ∃ U ∈ B, x ∈ U) ∧ ∀ U ∈ B, ∀ V ∈ B, ∀ x, x ∈ U → x ∈ V → ∃ W ∈ B, x ∈ W ∧ W ⊆ U ∧ W ⊆ V

-- the unions of subfamilies of B
def generated {n : Nat} (B : Family n) : Family n :=
  B.powerset.image (fun S => S.sup id)

def subbasic : Family 3 := {{0}, {0, 1, 2}, {1, 2}, {0, 2}}
