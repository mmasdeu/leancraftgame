/- Hidden test battery for Level 19: Spot the bug: sets. -/
import LeanCraftGame.Referee
import LeanCraftGame.L19.Player

open L19

/-- The colleague's definition. -/
def L19Ref.multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}

#no_sorry k₁
#no_sorry n₁
#no_sorry f₁
#no_sorry s₁
#no_sorry x₁
#no_sorry A
#no_sorry x₂
#no_sorry multiplesOfFixed
#level_start "Spot the bug: sets"

#expect_true "1. n₁ is a multiple of k₁" unfolding k₁ n₁ : k₁ ∣ n₁
#expect_true "1. n₁ is not in the colleague's multiplesOf k₁" unfolding k₁ n₁ L19Ref.multiplesOf :
  n₁ ∉ L19Ref.multiplesOf k₁
#expect_true "2. x₁ is in f₁ ⁻¹' (f₁ '' s₁)" unfolding x₁ f₁ s₁ Set.preimage Set.image :
  x₁ ∈ f₁ ⁻¹' (f₁ '' s₁)
#expect_true "2. x₁ is not in s₁" unfolding x₁ s₁ : x₁ ∉ s₁
#expect_true "3. x₂ is in ⋂ j, ⋃ i, A i j" unfolding x₂ A : x₂ ∈ ⋂ j, ⋃ i, A i j
#expect_true "3. x₂ is not in ⋃ i, ⋂ j, A i j" unfolding x₂ A : x₂ ∉ ⋃ i, ⋂ j, A i j
#expect_true "4. 12 ∈ multiplesOfFixed 4" unfolding multiplesOfFixed : 12 ∈ multiplesOfFixed 4
#expect_false "4. 4 ∈ multiplesOfFixed 12" unfolding multiplesOfFixed : 4 ∈ multiplesOfFixed 12
#expect_true "4. 0 ∈ multiplesOfFixed 5" unfolding multiplesOfFixed : 0 ∈ multiplesOfFixed 5
#expect_false "4. 7 ∈ multiplesOfFixed 2" unfolding multiplesOfFixed : 7 ∈ multiplesOfFixed 2

#level_report
