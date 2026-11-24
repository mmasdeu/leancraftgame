def product {m n : Nat} (T : Family m) (S : Family n) : Finset (Finset (Fin m × Fin n)) :=
  Finset.univ.filter (fun W => ∀ z ∈ W, ∃ U ∈ T, ∃ V ∈ S, z.1 ∈ U ∧ z.2 ∈ V ∧ U ×ˢ V ⊆ W)

def diagonal : Finset (Fin 2 × Fin 2) := Finset.univ.filter (fun z => z.1 = z.2)

def q1 : Bool := false
