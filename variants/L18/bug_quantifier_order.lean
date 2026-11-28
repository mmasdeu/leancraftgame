def Inj (f : ℕ → ℕ) : Prop := ∀ a b, f a = f b → a = b
def Surj (f : ℕ → ℕ) : Prop := ∃ a, ∀ b, f a = b
def pred' : ℕ → ℕ := fun n => n - 1
def q1 : Fin 3 := 0
def q2 : Bool := false
def q3 : Fin 3 := 2
