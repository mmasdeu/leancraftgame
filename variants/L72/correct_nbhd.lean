def nbhds {n : Nat} (T : Family n) (x : Fin n) : Family n :=
  Finset.univ.filter (fun A => ∃ U, U ∈ T ∧ x ∈ U ∧ U ⊆ A)

def IsFilter {n : Nat} (F : Family n) : Prop :=
  Finset.univ ∈ F ∧ ∅ ∉ F ∧ (∀ A B, A ∈ F → A ⊆ B → B ∈ F) ∧ ∀ A B, A ∈ F → B ∈ F → A ∩ B ∈ F

def Converges {n : Nat} (T : Family n) (u : ℕ → Fin n) (x : Fin n) : Prop :=
  ∀ U, U ∈ T → x ∈ U → ∃ N, ∀ k ≥ N, u k ∈ U

def twoLimits : ℕ → Fin 2 := fun k => if k < 3 then 0 else 1
