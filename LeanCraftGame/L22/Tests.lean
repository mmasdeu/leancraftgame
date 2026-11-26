/- Hidden test battery for Level 22: Recursion and induction. -/
import LeanCraftGame.Referee
import LeanCraftGame.L22.Player

open L22

/-- MIL's inequality, proved for the referee. -/
theorem L22Ref.fac_ge : ∀ n : ℕ, 2 ^ (n - 1) ≤ Nat.factorial n := by
  intro n
  induction n with
  | zero => simp
  | succ k ih =>
    rcases k with _ | k
    · simp
    · rw [Nat.factorial_succ]
      simp only [Nat.add_sub_cancel] at ih ⊢
      calc 2 ^ (k + 1) = 2 * 2 ^ k := by ring
        _ ≤ (k + 1 + 1) * Nat.factorial (k + 1) := Nat.mul_le_mul (by omega) ih

#no_sorry fac
#no_sorry fib
#no_sorry sumTo
#no_sorry collatz
#no_sorry L22.sum_id
#no_sorry L22.fac_ge
#level_start "Recursion and induction"

#expect_true "fac 0 = 1" : fac 0 = 1
#expect_true "fac 5 = 120" : fac 5 = 120
#expect_true "fib 10 = 55" : fib 10 = 55
#expect_true "fib 1 = 1 and fib 2 = 1" : fib 1 = 1 ∧ fib 2 = 1
#expect_true "sumTo 4 = 10" : sumTo 4 = 10
#expect_true "collatz 6 = 3" unfolding collatz : collatz 6 = 3
#expect_true "collatz 7 = 22" unfolding collatz : collatz 7 = 22
#expect_equiv "sum_id says ∑ i ∈ range (n + 1), i = n (n + 1) / 2" :
  L22.sum_id ↔ ∀ n : ℕ, ∑ i ∈ Finset.range (n + 1), i = n * (n + 1) / 2
  using fun n => by rw [Finset.sum_range_id]; simp [Nat.mul_comm]
#expect_equiv "fac_ge says 2 ^ (n - 1) ≤ n !" :
  L22.fac_ge ↔ ∀ n : ℕ, 2 ^ (n - 1) ≤ Nat.factorial n
  using L22Ref.fac_ge

#level_report
