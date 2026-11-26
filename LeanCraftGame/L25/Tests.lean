/- Hidden test battery for Level 25: Big operators and counting. -/
import LeanCraftGame.Referee
import LeanCraftGame.L25.Player

namespace L25Ref
theorem gauss_formula (n : ℕ) : ∑ i ∈ Finset.range (n + 1), i = n * (n + 1) / 2 := by
  rw [Finset.sum_range_id]; simp [Nat.mul_comm]
theorem gauss2 (n : ℕ) : (∑ i ∈ Finset.range (n + 1), i) * 2 = n * (n + 1) := by
  induction n with
  | zero => simp
  | succ n ih => rw [Finset.sum_range_succ, add_mul, ih]; ring
theorem cubes4 (n : ℕ) : (∑ i ∈ Finset.range (n + 1), i ^ 3) * 4 = (n * (n + 1)) ^ 2 := by
  induction n with
  | zero => simp
  | succ n ih => rw [Finset.sum_range_succ, add_mul, ih]; ring
theorem nicomachus (n : ℕ) :
    ∑ i ∈ Finset.range (n + 1), i ^ 3 = (∑ i ∈ Finset.range (n + 1), i) ^ 2 := by
  have h1 := gauss2 n
  have h2 := cubes4 n
  have : (∑ i ∈ Finset.range (n + 1), i ^ 3) * 4 = ((∑ i ∈ Finset.range (n + 1), i) ^ 2) * 4 := by
    rw [h2, ← h1]; ring
  exact Nat.eq_of_mul_eq_mul_right (by norm_num) this
end L25Ref

#no_sorry L25.gauss
#no_sorry L25.fact
#no_sorry L25.pairsLt
#no_sorry L25.gauss_formula
#no_sorry L25.nicomachus
#level_start "Big operators and counting"

#expect_true "the empty product ∏ i ∈ Finset.range 0, i is 1" : ∏ i ∈ Finset.range 0, i = 1
#expect_true "∏ i ∈ Finset.range 4, i is 0" : ∏ i ∈ Finset.range 4, i = 0
#expect_true "gauss 4 = 10" unfolding L25.gauss : L25.gauss 4 = 10
#expect_true "gauss 100 = 5050" unfolding L25.gauss : L25.gauss 100 = 5050
#expect_true "fact 0 = 1" unfolding L25.fact : L25.fact 0 = 1
#expect_true "fact 5 = 120" unfolding L25.fact : L25.fact 5 = 120
#expect_true "pairsLt 4 = 6" unfolding L25.pairsLt : L25.pairsLt 4 = 6
#expect_true "pairsLt 1 = 0" unfolding L25.pairsLt : L25.pairsLt 1 = 0
#expect_equiv "gauss_formula is Gauss's formula" :
  L25.gauss_formula ↔ ∀ n : ℕ, ∑ i ∈ Finset.range (n + 1), i = n * (n + 1) / 2
  using L25Ref.gauss_formula
#expect_equiv "nicomachus is Nicomachus's identity" :
  L25.nicomachus ↔ ∀ n : ℕ, ∑ i ∈ Finset.range (n + 1), i ^ 3 = (∑ i ∈ Finset.range (n + 1), i) ^ 2
  using L25Ref.nicomachus

#level_report
