def CommonDiv (d a b : ℕ) : Prop := d ∣ a ∧ d ∣ b

def Coprime' (a b : ℕ) : Prop := ¬ ∃ d, 1 < d ∧ CommonDiv d a b

def IsGcd (a b d : ℕ) : Prop := CommonDiv d a b ∧ ∀ e, CommonDiv e a b → e ∣ d

def IsPrime' (p : ℕ) : Prop := 1 < p ∧ ∀ d, 1 < d → d < p → ¬ d ∣ p

def Squarefree' (n : ℕ) : Prop := ¬ ∃ d, 1 < d ∧ d * d ∣ n
