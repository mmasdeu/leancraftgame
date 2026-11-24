def subspace {n : Nat} (T : Family n) (A : Finset (Fin n)) : Family n := T.image (fun U => U ∩ A)

def OpenIn {n : Nat} (T : Family n) (A W : Finset (Fin n)) : Prop := W ∈ subspace T A

def A0 : Finset (Fin 3) := {1, 2}
def W0 : Finset (Fin 3) := {1}

def D0 : Finset (Fin 3) := {1, 2}
