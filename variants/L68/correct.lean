def product {m n : Nat} (T : Family m) (S : Family n) : Finset (Finset (Fin m × Fin n)) :=
  Finset.univ.powerset.filter (fun W => ∀ z ∈ W, ∃ U ∈ T, ∃ V ∈ S, z ∈ U ×ˢ V ∧ U ×ˢ V ⊆ W)

def diagonal : Finset (Fin 2 × Fin 2) := {(0, 0), (1, 1)}

def q1 : Bool := false
