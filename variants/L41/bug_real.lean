def q1 : Fin 4 := 2
def q2 : Bool := false
def q3 : Fin 4 := 1
def q4 : Bool := true

statement exists_eig {V : Type} [AddCommGroup V] [Module ℂ V] [FiniteDimensional ℂ V]
    [Nontrivial V] (f : Module.End ℂ V) : ∃ c : ℂ, f.HasEigenvalue c

def A : Matrix (Fin 2) (Fin 2) ℚ := !![2, 1; 0, 3]

def ev₁ : ℚ := 2
def vec₁ : Fin 2 → ℚ := ![1, 0]
def ev₂ : ℚ := 3
def vec₂ : Fin 2 → ℚ := ![1, 1]
