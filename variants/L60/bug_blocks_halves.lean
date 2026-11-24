def IsEquivalence {n : Nat} (R : Fin n → Fin n → Bool) : Prop :=
  (∀ x, R x x = true) ∧ (∀ x y, R x y = true → R y x = true) ∧
    (∀ x y z, R x y = true → R y z = true → R x z = true)

def cls {n : Nat} (R : Fin n → Fin n → Bool) (x : Fin n) : Finset (Fin n) :=
  Finset.univ.filter (fun y => R x y = true)

def kernel {m n : Nat} (f : Fin m → Fin n) : Fin m → Fin m → Bool := fun x y => f x == f y

def twoBlocks : Fin 4 → Fin 4 → Bool := fun x y => decide (x.val < 2) == decide (y.val < 2)
