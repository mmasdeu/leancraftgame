statement lagrange : ∀ {G : Type*} [Group G] (H : Subgroup G), Nat.card H ∣ Nat.card G

statement cauchy {G : Type*} [Group G] [Fintype G] (p : ℕ) (hdvd : p ∣ Fintype.card G)
    (hp : Nat.Prime p) : ∃ x : G, orderOf x = p

def ord4 : ℕ := 3

def σ : Equiv.Perm (Fin 3) := Equiv.swap 1 2 * Equiv.swap 0 1

def τ : Equiv.Perm (Fin 3) := Equiv.swap 1 2
