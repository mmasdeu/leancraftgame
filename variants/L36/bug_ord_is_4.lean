statement lagrange {G : Type*} [Group G] (H : Subgroup G) : Nat.card H ∣ Nat.card G

statement cauchy {G : Type*} [Group G] [Fintype G] (p : ℕ) (hp : p.Prime)
    (hdvd : p ∣ Fintype.card G) : ∃ x : G, orderOf x = p

def ord4 : ℕ := 4

def σ : Equiv.Perm (Fin 3) := Equiv.swap 0 1 * Equiv.swap 1 2

def τ : Equiv.Perm (Fin 3) := Equiv.swap 0 1
