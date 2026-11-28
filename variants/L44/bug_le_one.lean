def collatz (n : ℕ) : ℕ := if n % 2 = 0 then n / 2 else 3 * n + 1

def GoldbachFor (P : ℕ → Prop) : Prop :=
  ∀ n, 2 < n → n % 2 = 0 → ∃ p q, P p ∧ P q ∧ p + q = n

def CollatzFor (o : ℕ → ℕ → ℕ) : Prop :=
  ∀ n, 0 < n → ∃ k, o n k ≤ 1

def q1 : Bool := false
def q2 : Bool := true
def q3 : Bool := false
