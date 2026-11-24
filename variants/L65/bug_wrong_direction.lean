-- the inverse image of a T-open set... in the wrong space: S-open sets pulled back must be T-open,
-- not the other way round
def pre {m n : Nat} (f : Fin m → Fin n) (V : Finset (Fin n)) : Finset (Fin m) :=
  Finset.univ.filter (fun x => f x ∈ V)

def img {m n : Nat} (f : Fin m → Fin n) (A : Finset (Fin m)) : Finset (Fin n) :=
  Finset.univ.filter (fun y => ∃ x ∈ A, f x = y)

def IsContinuous {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ V, pre f V ∈ T → V ∈ S

def IsOpenMapping {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ U ∈ T, img f U ∈ S

def sneaky : Fin 2 → Fin 2 := ![0, 1]
