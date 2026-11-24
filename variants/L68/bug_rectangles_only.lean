-- only the rectangles themselves: not closed under unions
def product {m n : Nat} (T : Family m) (S : Family n) : Finset (Finset (Fin m × Fin n)) :=
  (T ×ˢ S).image (fun p => p.1 ×ˢ p.2)

def diagonal : Finset (Fin 2 × Fin 2) := {(0, 0), (1, 1)}

def q1 : Bool := false
