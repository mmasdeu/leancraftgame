statement irr_sqrt2 : Irrational (√2)

statement no_rat_sqrt : ¬ ∃ q : ℕ, q ^ 2 = 2

statement sqrt2_nat : ∀ m n : ℕ, Nat.Coprime m n → m ^ 2 ≠ 2 * n ^ 2

statement prime_sqrt {m n p : ℕ} (nnz : n ≠ 0) (prime_p : p.Prime) : m ^ 2 ≠ p * n ^ 2
