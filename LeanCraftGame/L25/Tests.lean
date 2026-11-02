/- Hidden test battery for Level Injective and surjective. -/
import LeanCraftGame.Referee
import LeanCraftGame.L25.Player

open L25

#no_sorry Injective
#no_sorry Surjective
#no_sorry Bijective
#level_start "Level Injective and surjective"

-- n + 1: injective, not surjective (nothing hits 0)
#expect_true "Injective (n + 1) is true" unfolding Injective :
  Injective (fun n => n + 1)
#expect_false "Surjective (n + 1) is false (nothing is sent to 0)" unfolding Surjective :
  Surjective (fun n => n + 1)
-- n - 1 truncated: surjective, not injective (0 and 1 both go to 0)
#expect_true "Surjective (n - 1) is true (y is hit by y + 1)" unfolding Surjective :
  Surjective (fun n => n - 1)
#expect_false "Injective (n - 1) is false (0 and 1 both go to 0)" unfolding Injective :
  Injective (fun n => n - 1)
-- n % 3: neither
#expect_false "Surjective (n % 3) is false (3 is never hit)" unfolding Surjective :
  Surjective (fun n => n % 3)
-- 2 * n: injective, not surjective
#expect_true "Injective (2 * n) is true" unfolding Injective :
  Injective (fun n => 2 * n)
#expect_false "Surjective (2 * n) is false (1 is never hit)" unfolding Surjective :
  Surjective (fun n => 2 * n)
-- constant
#expect_false "Surjective (fun _ => 0) is false (1 is never hit)" unfolding Surjective :
  Surjective (fun _ => 0)
#expect_false "Injective (fun _ => 0) is false" unfolding Injective :
  Injective (fun _ => 0)
-- the identity
#expect_true "Bijective (n) is true" unfolding Bijective Injective Surjective :
  Bijective (fun n => n)
-- swapping neighbours 0↔1, 2↔3, 4↔5, … (its surjectivity is beyond the referee: a witness that depends on parity)
#expect_true "Injective (swap neighbours: 1, 0, 3, 2, …) is true" unfolding Injective :
  Injective (fun n => if n % 2 = 0 then n + 1 else n - 1)
-- bijective is both, not either
#expect_false "Bijective (n + 1) is false (injective is not enough)" unfolding Bijective Injective Surjective :
  Bijective (fun n => n + 1)
-- lemmas (two different inputs with the same output: not injective, not bijective)
#expect_true "Injective f fails as soon as two different inputs collide" unfolding Injective :
  ∀ f : ℕ → ℕ, ∀ a b, a ≠ b → f a = f b → ¬ Injective f
#expect_true "Bijective f fails as soon as two different inputs collide" unfolding Bijective Injective :
  ∀ f : ℕ → ℕ, ∀ a b, a ≠ b → f a = f b → ¬ Bijective f
#expect_true "Injective f implies Injective (f n + 1)" unfolding Injective :
  ∀ f : ℕ → ℕ, Injective f → Injective (fun n => f n + 1)
#expect_true "Bijective f implies Surjective f" unfolding Bijective Surjective :
  ∀ f : ℕ → ℕ, Bijective f → Surjective f
#expect_true "Bijective f implies Injective f" unfolding Bijective Injective :
  ∀ f : ℕ → ℕ, Bijective f → Injective f

#level_report
