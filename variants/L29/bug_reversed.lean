-- n is even and at least 4 (already done, with Mathlib's `Even`)
def BigEven (n : ℕ) : Prop := Even n ∧ 4 ≤ n

-- n is abundant: the sum of its proper divisors exceeds n   (12 < 1 + 2 + 3 + 4 + 6)
def IsAbundant (n : ℕ) : Prop := n < ∑ d ∈ n.properDivisors, d

-- d divides both a and b                               (CommonDivisor 3 6 9)
def CommonDivisor (d a b : ℕ) : Prop := a ∣ d ∧ b ∣ d

-- f never takes the same value twice (use Mathlib's name for this)
def OneToOne (f : ℕ → ℕ) : Prop := Function.Injective f
