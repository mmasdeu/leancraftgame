/- Hidden test battery for Level 39: Vector spaces and linear maps. -/
import LeanCraftGame.Referee
import LeanCraftGame.L39.Player

open L39

#no_sorry rot
#no_sorry proj
#no_sorry u
#no_sorry w
#level_start "Vector spaces and linear maps"

#expect_true "rot sends ![1, 0] to ![0, 1]" unfolding rot : rot ![1, 0] = ![0, 1]
#expect_true "rot sends ![0, 1] to ![-1, 0]" unfolding rot : rot ![0, 1] = ![-1, 0]
#expect_true "rot is additive (map_add')" unfolding rot :
  ∀ x y : Fin 2 → ℚ, rot (x + y) = rot x + rot y
#expect_true "rot commutes with scalars (map_smul')" unfolding rot :
  ∀ (c : ℚ) (x : Fin 2 → ℚ), rot (c • x) = c • rot x
#expect_true "proj sends ![3, 5] to ![3, 0]" unfolding proj : proj ![3, 5] = ![3, 0]
#expect_true "proj sends ![0, 7] to the zero vector" unfolding proj : proj ![0, 7] = ![0, 0]
#expect_true "proj is additive (map_add')" unfolding proj :
  ∀ x y : Fin 2 → ℚ, proj (x + y) = proj x + proj y
#expect_true "proj commutes with scalars (map_smul')" unfolding proj :
  ∀ (c : ℚ) (x : Fin 2 → ℚ), proj (c • x) = c • proj x
#expect_false "shift sends the zero vector to zero" unfolding shift :
  shift ![0, 0] = ![0, 0]
#expect_true "your u and w: shift (u + w) ≠ shift u + shift w" unfolding shift u w :
  shift (u + w) ≠ shift u + shift w

#level_report
