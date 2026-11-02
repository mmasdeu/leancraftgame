-- the even numbers (already done)
def evens : Set ℕ := {n | n % 2 = 0}

-- the multiples of k: 0, k, 2k, 3k, …     (12 ∈ multiplesOf 3, but not 13)
def multiplesOf (k : ℕ) : Set ℕ := {n | n % k = 0}

-- some number B is at least as big as every element of s
def BoundedSet (s : Set ℕ) : Prop := ∀ n ∈ s, ∃ B, n ≤ B
