-- forgot x ∈ U: every point is interior as soon as some open set fits in A
def IsClosed {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := Aᶜ ∈ T

def interior {n : Nat} (T : Family n) (A : Finset (Fin n)) : Finset (Fin n) :=
  Finset.univ.filter (fun _ => ∃ U ∈ T, U ⊆ A ∧ U.Nonempty)

def closure {n : Nat} (T : Family n) (A : Finset (Fin n)) : Finset (Fin n) :=
  Finset.univ.filter (fun x => ∀ U ∈ T, x ∈ U → (U ∩ A).Nonempty)

def IsDense {n : Nat} (T : Family n) (A : Finset (Fin n)) : Prop := closure T A = Finset.univ
