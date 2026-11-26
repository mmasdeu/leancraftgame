statement irr_sqrt2 : Irrational (Real.sqrt 2)

statement no_rat_sqrt : ∀ q : ℚ, (q : ℝ) ≠ Real.sqrt 2

statement sqrt2_nat (m n : ℕ) (h : m.Coprime n) : m ^ 2 ≠ 2 * n ^ 2

statement prime_sqrt {m n p : ℕ} (prime_p : Nat.Prime p) (nnz : n ≠ 0) : m ^ 2 ≠ p * n ^ 2
