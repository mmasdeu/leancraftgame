def CommonDiv (d a b : ℕ) : Prop := d ∣ a ∧ d ∣ b

def Coprime' (a b : ℕ) : Prop := ∀ d, d ∣ a → d ∣ b → d = 1

def IsGcd (a b d : ℕ) : Prop := d ∣ a ∧ d ∣ b ∧ ∀ e, e ∣ a → e ∣ b → e ∣ d

def IsPrime' (p : ℕ) : Prop := ∀ d, 1 < d → d < p → ¬ d ∣ p

def Squarefree' (n : ℕ) : Prop := ∀ d, d * d ∣ n → d = 1
