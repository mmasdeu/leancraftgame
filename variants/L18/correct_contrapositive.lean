def Inj (f : ℕ → ℕ) : Prop := ∀ {a b}, a ≠ b → f a ≠ f b
def Surj (f : ℕ → ℕ) : Prop := ∀ y : ℕ, ∃ x : ℕ, y = f x
def pred' : ℕ → ℕ := Nat.pred
def q1 : Fin 3 := 0
def q2 : Bool := false
def q3 : Fin 3 := 2
