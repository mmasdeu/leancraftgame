/- Hidden test battery for Level 34: Morphisms. -/
import LeanCraftGame.Referee
import LeanCraftGame.L34.Player

open L34

#no_sorry IsMonoidHom
#no_sorry IsAddMonoidHom
#no_sorry homNotOnto
#no_sorry bijNotHom
#level_start "Morphisms"

#expect_true "n ↦ n² is a homomorphism of (ℕ, *)" unfolding IsMonoidHom :
  IsMonoidHom (fun n : ℕ => n ^ 2)
#expect_false "The constant map 0 is a homomorphism of (ℕ, *)" unfolding IsMonoidHom :
  IsMonoidHom (fun _ : ℕ => (0 : ℕ))
#expect_false "n ↦ 2n is a homomorphism of (ℕ, *)" unfolding IsMonoidHom :
  IsMonoidHom (fun n : ℕ => 2 * n)
#expect_false "n ↦ -n is a homomorphism of (ℤ, *)" unfolding IsMonoidHom :
  IsMonoidHom (fun n : ℤ => -n)
#expect_true "Every bundled f : ℕ →* ℤ satisfies IsMonoidHom f" unfolding IsMonoidHom :
  ∀ f : ℕ →* ℤ, IsMonoidHom f
#expect_true "n ↦ 3n is a homomorphism of (ℤ, +)" unfolding IsAddMonoidHom :
  IsAddMonoidHom (fun n : ℤ => 3 * n)
#expect_false "n ↦ n + 1 is a homomorphism of (ℤ, +)" unfolding IsAddMonoidHom :
  IsAddMonoidHom (fun n : ℤ => n + 1)
#expect_false "n ↦ 2ⁿ is a homomorphism of (ℕ, +)" unfolding IsAddMonoidHom :
  IsAddMonoidHom (fun n : ℕ => 2 ^ n)
#expect_true "Every bundled f : ℤ →+ ℤ satisfies IsAddMonoidHom f" unfolding IsAddMonoidHom :
  ∀ f : ℤ →+ ℤ, IsAddMonoidHom f
#expect_true "homNotOnto preserves 0 and +" unfolding homNotOnto :
  homNotOnto 0 = 0 ∧ ∀ a b, homNotOnto (a + b) = homNotOnto a + homNotOnto b
#expect_false "homNotOnto is surjective" unfolding homNotOnto :
  ∀ m, ∃ n, homNotOnto n = m
#expect_true "bijNotHom is its own inverse" unfolding bijNotHom :
  ∀ n, bijNotHom (bijNotHom n) = n
#expect_false "bijNotHom preserves 0 and +" unfolding bijNotHom :
  bijNotHom 0 = 0 ∧ ∀ a b, bijNotHom (a + b) = bijNotHom a + bijNotHom b

#level_report
