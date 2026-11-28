def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
def SomePositive (u : ℕ → ℝ) : Prop := ∃ n, n > 0 → u n > 0
def BoundedAbove (f : ℝ → ℝ) : Prop := ∀ x, ∃ M, f x ≤ M
def seqA : ℕ → ℝ := fun _ => 0
def limA : ℝ := 0
def seqB : ℕ → ℝ := fun _ => 0
def limB : ℝ := 0
def seqC : ℕ → ℝ := fun _ => -1
def funD : ℝ → ℝ := fun x => x
