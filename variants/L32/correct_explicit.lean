
structure AddSubmonoid₁ (M : Type) [AddMonoid M] where
  carrier : Set M
  add_mem : ∀ a b, a ∈ carrier → b ∈ carrier → a + b ∈ carrier
  zero_mem : 0 ∈ carrier

-- the even natural numbers
def evens : Set ℕ := {n | n % 2 = 0}

-- the natural numbers divisible by k
def multiplesOf (k : ℕ) : Set ℕ := {n | n % k = 0}

