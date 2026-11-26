def collatz (n : ℕ) : ℕ := if n % 2 = 0 then n / 2 else 3 * n + 1

def GoldbachFor (P : ℕ → Prop) : Prop :=
  ∀ n, 4 ≤ n → 2 ∣ n → ∃ p q, P p ∧ P q ∧ n = p + q

def CollatzFor (o : ℕ → ℕ → ℕ) : Prop :=
  ∀ n > 0, ∃ k, o n k = 1

def q1 : Bool := false
def q2 : Bool := true
def q3 : Bool := false
