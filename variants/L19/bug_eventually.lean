-- every natural number is a value of f
def HitsEverything (f : Nat → Nat) : Prop := ∀ m, ∃ n, f n = m

-- the sequence gets above every bound M at least once
def Unbounded (u : Nat → Nat) : Prop := ∃ M, ∀ n, M ≤ u n
