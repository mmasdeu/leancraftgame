/- Hidden test battery for Level 21: Irrational roots. -/
import LeanCraftGame.Referee
import LeanCraftGame.L21.Player

/-- The theorem on ℕ, proved for the referee. -/
theorem L21Ref.sqrt2_nat : ∀ m n : ℕ, Nat.Coprime m n → m ^ 2 ≠ 2 * n ^ 2 := by
  intro m n hc h
  have h2 : 2 ∣ m := Nat.prime_two.dvd_of_dvd_pow ⟨n ^ 2, h⟩
  obtain ⟨k, rfl⟩ := h2
  have hn : 2 ∣ n := by
    have : n ^ 2 = 2 * k ^ 2 := by nlinarith
    exact Nat.prime_two.dvd_of_dvd_pow ⟨k ^ 2, this⟩
  have : 2 ∣ Nat.gcd (2 * k) n := Nat.dvd_gcd ⟨k, rfl⟩ hn
  rw [hc] at this
  omega

theorem L21Ref.no_rat : ¬ ∃ q : ℚ, (q : ℝ) = Real.sqrt 2 :=
  fun ⟨q, hq⟩ => irrational_sqrt_two ⟨q, hq⟩

#no_sorry L21.irr_sqrt2
#no_sorry L21.no_rat_sqrt
#no_sorry L21.sqrt2_nat
#no_sorry L21.prime_sqrt
#level_start "Irrational roots"

#expect_type "irr_sqrt2 is a proposition" : L21.irr_sqrt2 : Prop
#expect_equiv "irr_sqrt2 says √2 is irrational" :
  L21.irr_sqrt2 ↔ Irrational (Real.sqrt 2)
  using irrational_sqrt_two
#expect_equiv "no_rat_sqrt says no rational equals √2" :
  L21.no_rat_sqrt ↔ ¬ ∃ q : ℚ, (q : ℝ) = Real.sqrt 2
  using L21Ref.no_rat
#expect_equiv "sqrt2_nat says m² ≠ 2n² for coprime m, n" :
  L21.sqrt2_nat ↔ ∀ m n : ℕ, Nat.Coprime m n → m ^ 2 ≠ 2 * n ^ 2
  using L21Ref.sqrt2_nat
#expect_equiv "prime_sqrt says m² ≠ p n² for n ≠ 0 and p prime" :
  L21.prime_sqrt ↔ ∀ {m n p : ℕ}, n ≠ 0 → p.Prime → m ^ 2 ≠ p * n ^ 2

#level_report
