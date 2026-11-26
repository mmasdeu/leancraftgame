statement sq_add {x y : ℝ} : x ^ 2 + 2 * x * y + y ^ 2 = (x + y) ^ 2
statement two_mul_le : ∀ a b : ℝ, a ^ 2 + b ^ 2 ≥ 2 * (a * b)
statement abs_mul_le (a b : ℝ) : |a * b| ≤ (b ^ 2 + a ^ 2) / 2
statement min_comm' (x y : ℝ) : min y x = min x y
statement max_assoc' (a b c : ℝ) : max (max a b) c = max a (max b c)
