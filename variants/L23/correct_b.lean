def IsPrime (p : ℕ) : Prop := ∀ d, d ∣ p → d = 1 ∨ d = p

def AIClaim (P : ℕ → Prop) : Prop := ∀ n, ∃ p, P p ∧ p ≠ n

def Unbounded (P : ℕ → Prop) : Prop := ∀ n, ∃ p ≥ n, P p

def smallWorld : ℕ → Prop := fun p => p = 2 ∨ p = 3 ∨ p = 5

def fakePrime : ℕ := 1

statement euclid (n : ℕ) : ∃ p, p ≥ n ∧ p.Prime

statement euclid_mod4 (n : ℕ) : ∃ p, p ≥ n ∧ p.Prime ∧ p % 4 = 3

def q1 : Fin 3 := 1
def q2 : Bool := true
