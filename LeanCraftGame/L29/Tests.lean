/- Hidden test battery for Level 32: Classes and instances. -/
import LeanCraftGame.Referee
import LeanCraftGame.L29.Player

open L29

#no_sorry L29.boolXor
#no_sorry L29.intAdd
#no_sorry L29.endo
#level_start "Classes and instances"

#expect_true "mpow 2 10 = 1024 in (ℕ, *)" :
  mpow (2 : ℕ) 10 = 1024
#expect_true "In (Bool, xor): mpow true 3 = true and mpow true 4 = false" :
  mpow true 3 = true ∧ mpow true 4 = false
#expect_true "(Bool, xor) is associative, with unit false on both sides" :
  ∀ a b c : Bool, (a ⋄ b) ⋄ c = a ⋄ (b ⋄ c) ∧ One₁.one ⋄ a = a ∧ a ⋄ One₁.one = a
#expect_true "In (Bool, xor) every element is its own inverse" :
  ∀ a : Bool, a ⋄ a = One₁.one
#expect_true "In (ℤ, +): mpow 5 3 = 15 and mpow (-2) 4 = -8" :
  mpow (5 : ℤ) 3 = 15 ∧ mpow (-2 : ℤ) 4 = -8
#expect_true "In (ℤ, +): the unit is a unit on both sides" :
  One₁.one ⋄ (7 : ℤ) = 7 ∧ (-3 : ℤ) ⋄ One₁.one = -3 ∧ (2 : ℤ) ⋄ 3 = 5
#expect_true "In (ℕ → ℕ, ∘): mpow (fun n => n + 3) 4 sends 0 to 12" :
  mpow (fun n : ℕ => n + 3) 4 0 = 12
#expect_true "f ⋄ g is \"first g, then f\": (· * 2) ⋄ (· + 1) sends 5 to 12" :
  ((fun n : ℕ => n * 2) ⋄ (fun n => n + 1)) 5 = 12
#expect_true "The unit of (ℕ → ℕ, ∘) is the identity" :
  (One₁.one : ℕ → ℕ) 7 = 7 ∧ (One₁.one : ℕ → ℕ) 0 = 0

#level_report
