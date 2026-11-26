statement sq_sub_sq' {A : Type*} [CommRing A] (x y : A) : x ^ 2 - y ^ 2 = (x + y) * (x - y)
statement absorb {L : Type*} [Lattice L] (a b : L) : a ⊓ (a ⊔ b) = a
statement max_comm' {α : Type*} [LinearOrder α] (x y : α) : max y x = max x y
statement dist_triangle' {M : Type*} [MetricSpace M] (a b c : M) : dist a b + dist b c ≥ dist a c
