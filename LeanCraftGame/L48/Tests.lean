/- Hidden test battery for Level Morphisms. -/
import LeanCraftGame.Referee
import LeanCraftGame.L48.Player

open L48

#no_sorry IsAddHom
#no_sorry IsExpHom
#no_sorry homNotOnto
#no_sorry bijNotHom
#level_start "Morphisms"

#expect_true "n ↦ 3n is an additive homomorphism" unfolding IsAddHom :
  IsAddHom (fun n => 3 * n)
#expect_false "n ↦ n + 1 is an additive homomorphism" unfolding IsAddHom :
  IsAddHom (fun n => n + 1)
#expect_false "n ↦ n² is an additive homomorphism" unfolding IsAddHom :
  IsAddHom (fun n => n * n)
#expect_true "The zero map is an additive homomorphism" unfolding IsAddHom :
  IsAddHom (fun _ => 0)
#expect_true "n ↦ 2ⁿ is a homomorphism from (ℕ, +) to (ℕ, ·)" unfolding IsExpHom :
  IsExpHom (fun n => 2 ^ n)
#expect_false "n ↦ 2n is a homomorphism from (ℕ, +) to (ℕ, ·)" unfolding IsExpHom :
  IsExpHom (fun n => 2 * n)
#expect_true "The constant map 1 is a homomorphism from (ℕ, +) to (ℕ, ·)" unfolding IsExpHom :
  IsExpHom (fun _ => 1)
#expect_false "The constant map 0 is a homomorphism from (ℕ, +) to (ℕ, ·)" unfolding IsExpHom :
  IsExpHom (fun _ => 0)
#expect_true "homNotOnto preserves 0 and addition" unfolding homNotOnto :
  homNotOnto 0 = 0 ∧ ∀ a b, homNotOnto (a + b) = homNotOnto a + homNotOnto b
#expect_true "homNotOnto misses some number" unfolding homNotOnto :
  ∃ m, ∀ n, homNotOnto n ≠ m
#expect_true "bijNotHom is its own inverse (so it is a bijection)" unfolding bijNotHom :
  ∀ n, bijNotHom (bijNotHom n) = n
#expect_false "bijNotHom preserves 0 and addition" unfolding bijNotHom :
  bijNotHom 0 = 0 ∧ ∀ a b, bijNotHom (a + b) = bijNotHom a + bijNotHom b

#level_report
