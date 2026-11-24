-- "pre" that keeps the points NOT sent into V
def Disj {n : Nat} (A B : Finset (Fin n)) : Prop := A ∩ B = ∅

def pre {m n : Nat} (f : Fin m → Fin n) (V : Finset (Fin n)) : Finset (Fin m) :=
  Finset.univ.filter (fun x => f x ∉ V)

def img {m n : Nat} (f : Fin m → Fin n) (A : Finset (Fin m)) : Finset (Fin n) :=
  Finset.univ.filter (fun y => ∃ x ∈ A, f x = y)

def f0 : Fin 2 → Fin 2 := ![0, 0]
def A0 : Finset (Fin 2) := {0}
def B0 : Finset (Fin 2) := {1}
