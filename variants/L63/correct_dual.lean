def IsClosed {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := Aᶜ ∈ T

def interior {n : Nat} (T : Family n) (A : Finset (Fin n)) : Finset (Fin n) :=
  Finset.univ.filter (fun x => ∃ U ∈ T, x ∈ U ∧ U ⊆ A)

-- the closure is the complement of the interior of the complement
def closure {n : Nat} (T : Family n) (A : Finset (Fin n)) : Finset (Fin n) := (interior T Aᶜ)ᶜ

def IsDense {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := ∀ x, x ∈ closure T A
