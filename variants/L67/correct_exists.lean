def subspace {n : Nat} (T : Family n) (A : Finset (Fin n)) : Family n :=
  A.powerset.filter (fun W => ∃ U ∈ T, U ∩ A = W)

def OpenIn {n : Nat} (T : Family n) (A W : Finset (Fin n)) : Prop := ∃ U ∈ T, U ∩ A = W

def A0 : Finset (Fin 3) := {2, 1}
def W0 : Finset (Fin 3) := {1, 2}

def D0 : Finset (Fin 3) := {2, 1}
