-- n is even and at least 4 (already done, with Mathlib's `Even`)
def BigEven (n : ℕ) : Prop := Even n ∧ 4 ≤ n

-- n is perfect: the sum of its proper divisors is n   (6 = 1 + 2 + 3)
def IsPerfect (n : ℕ) : Prop := ∑ d ∈ n.properDivisors, d = n

-- d divides both a and b                               (CommonDivisor 3 6 9)
def CommonDivisor (d a b : ℕ) : Prop := d ∣ a ∧ d ∣ b

-- f never takes the same value twice (use Mathlib's name for this)
def OneToOne (f : ℕ → ℕ) : Prop := Function.Surjective f
