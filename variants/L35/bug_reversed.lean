
structure AddSubmonoid₁ (M : Type) [AddMonoid M] where
  carrier : Set M
  zero_mem : (0 : M) ∈ carrier
  add_mem {a b} : a + b ∈ carrier → a ∈ carrier ∧ b ∈ carrier

-- the even natural numbers
def evens : Set ℕ := {n | n % 2 = 0}

-- the natural numbers divisible by k
def multiplesOf (k : ℕ) : Set ℕ := {n | k ∣ n}

