def pre {m n : Nat} (f : Fin m → Fin n) (V : Finset (Fin n)) : Finset (Fin m) :=
  Finset.univ.filter (fun x => f x ∈ V)

def IsContinuous {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ V ∈ S, pre f V ∈ T

def IsHomeo {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∃ g : Fin n → Fin m, IsContinuous T S f ∧ IsContinuous S T g

def mirror : Fin 2 → Fin 2 := ![1, 0]

def q1 : Bool := false
def q2 : Bool := true
def q3 : Bool := false
