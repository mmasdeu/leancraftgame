-- "infinitely often" instead of "eventually"
def nbhds {n : Nat} (T : Family n) (x : Fin n) : Family n :=
  Finset.univ.powerset.filter (fun A => ∃ U ∈ T, x ∈ U ∧ U ⊆ A)

def IsFilter {n : Nat} (F : Family n) : Prop :=
  Finset.univ ∈ F ∧ ∅ ∉ F ∧ (∀ A ∈ F, ∀ B : Finset (Fin n), A ⊆ B → B ∈ F) ∧
    ∀ A ∈ F, ∀ B ∈ F, A ∩ B ∈ F

def Converges {n : Nat} (T : Family n) (u : ℕ → Fin n) (x : Fin n) : Prop :=
  ∀ U ∈ T, x ∈ U → ∀ N, ∃ k, N ≤ k ∧ u k ∈ U

def twoLimits : ℕ → Fin 2 := fun k => if k = 0 then 0 else 1
