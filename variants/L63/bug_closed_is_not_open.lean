def IsClosed {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := A ∉ T

def interior {n : Nat} (T : Family n) (A : Finset (Fin n)) : Finset (Fin n) :=
  Finset.univ.filter (fun x => ∃ U ∈ T, x ∈ U ∧ U ⊆ A)

def closure {n : Nat} (T : Family n) (A : Finset (Fin n)) : Finset (Fin n) :=
  Finset.univ.filter (fun x => ∀ U ∈ T, x ∈ U → (U ∩ A).Nonempty)

def IsDense {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := closure T A = Finset.univ
