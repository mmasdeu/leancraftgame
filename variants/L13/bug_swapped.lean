-- every natural number is a value of f
def HitsEverything (f : Nat → Nat) : Prop := ∃ n, ∀ m, f n = m

-- the sequence gets above every bound M at least once
def Unbounded (u : Nat → Nat) : Prop := ∃ n, ∀ M, M ≤ u n
