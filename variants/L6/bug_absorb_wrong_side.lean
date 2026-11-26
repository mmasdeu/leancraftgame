statement sq_sub_sq' {R : Type*} [CommRing R] (a b : R) : (a + b) * (a - b) = a ^ 2 - b ^ 2
statement absorb {α : Type*} [Lattice α] (x y : α) : x ⊓ (x ⊔ y) = y
statement max_comm' {α : Type*} [LinearOrder α] (a b : α) : max a b = max b a
statement dist_triangle' {X : Type*} [MetricSpace X] (x y z : X) : dist x z ≤ dist x y + dist y z
