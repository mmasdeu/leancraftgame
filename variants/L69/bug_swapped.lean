-- "∀ x, ∃ N" instead of "∃ N, ∀ x": every cover passes
def Covers (U : ℕ → Set ℕ) : Prop := ∀ x, ∃ i, x ∈ U i

def HasFiniteSubcover (U : ℕ → Set ℕ) : Prop := ∀ x, ∃ N, ∃ i ≤ N, x ∈ U i

def noSubcover : ℕ → Set ℕ := fun i => {i}

def N0 : ℕ := 4
