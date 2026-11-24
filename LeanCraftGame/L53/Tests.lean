/- Hidden test battery for Level Classes and instances. -/
import LeanCraftGame.Referee
import LeanCraftGame.L53.Player

open L53 L53.Monoid'

#no_sorry boolXor
#no_sorry listAppend
#no_sorry endo
#level_start "Classes and instances"

#expect_true "mpow 2 10 = 1024 in (ℕ, ·)" :
  mpow (2 : ℕ) 10 = 1024
#expect_true "In (Bool, xor): mpow true 3 = true and mpow true 4 = false (parity)" :
  mpow true 3 = true ∧ mpow true 4 = false
#expect_true "(Bool, xor) is associative, with unit false" :
  ∀ a b c : Bool, op (op a b) c = op a (op b c) ∧ op unit a = a ∧ op a unit = a
#expect_true "In (Bool, xor) every element is its own inverse" :
  ∀ a : Bool, op a a = unit
#expect_true "mpow [1, 2] 3 = [1, 2, 1, 2, 1, 2]" :
  mpow ([1, 2] : List ℕ) 3 = [1, 2, 1, 2, 1, 2]
#expect_true "mpow [] 5 = [] and mpow [7] 0 = []" :
  mpow ([] : List ℕ) 5 = [] ∧ mpow ([7] : List ℕ) 0 = []
#expect_true "In (ℕ → ℕ, ∘): mpow (fun n => n + 3) 4 sends 0 to 12" :
  mpow (fun n : ℕ => n + 3) 4 0 = 12
#expect_true "op f g is \"first g, then f\": op (· * 2) (· + 1) sends 5 to 12" :
  op (fun n : ℕ => n * 2) (fun n => n + 1) 5 = 12
#expect_true "The unit of (ℕ → ℕ, ∘) is the identity" :
  (unit : ℕ → ℕ) 7 = 7 ∧ (unit : ℕ → ℕ) 0 = 0

#level_report
