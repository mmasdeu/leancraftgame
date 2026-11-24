def IsEquivalence {n : Nat} (R : Fin n → Fin n → Bool) : Prop :=
  ∀ x y z, R x x ∧ (R x y → R y x) ∧ (R x y → R y z → R x z)

def cls {n : Nat} (R : Fin n → Fin n → Bool) (x : Fin n) : Finset (Fin n) :=
  Finset.univ.filter (fun y => R x y)

def kernel {m n : Nat} (f : Fin m → Fin n) : Fin m → Fin m → Bool := fun x y => decide (f x = f y)

-- the kernel of a map with a fibre of size 1 and a fibre of size 3
def twoBlocks : Fin 4 → Fin 4 → Bool := kernel (![0, 0, 1, 0] : Fin 4 → Fin 2)
