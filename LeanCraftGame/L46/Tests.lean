/- Hidden test battery for Level Defaults and updates. -/
import LeanCraftGame.Referee
import LeanCraftGame.L46.Player

open L46

#no_sorry identity
#no_sorry shear
#no_sorry transpose
#no_sorry det
#no_sorry mul
#level_start "Defaults and updates"

#expect_true "identity = (1 0 / 0 1)" unfolding identity :
  identity.a = 1 ∧ identity.b = 0 ∧ identity.c = 0 ∧ identity.d = 1
#expect_true "shear 5 = (1 5 / 0 1)" unfolding shear :
  (shear 5).a = 1 ∧ (shear 5).b = 5 ∧ (shear 5).c = 0 ∧ (shear 5).d = 1
#expect_true "transpose (1 2 / 3 4) = (1 3 / 2 4)" unfolding transpose :
  (transpose ⟨1, 2, 3, 4⟩).a = 1 ∧ (transpose ⟨1, 2, 3, 4⟩).b = 3 ∧ (transpose ⟨1, 2, 3, 4⟩).c = 2 ∧ (transpose ⟨1, 2, 3, 4⟩).d = 4
#expect_true "det (1 2 / 3 4) = -2" unfolding det :
  det ⟨1, 2, 3, 4⟩ = -2
#expect_true "det (shear k) = 1 for -3 ≤ k ≤ 3" unfolding det shear :
  ∀ k ∈ Finset.Icc (-3 : ℤ) 3, det (shear k) = 1
#expect_true "det (transpose M) = det M on sample matrices" unfolding det transpose :
  ∀ M ∈ [(⟨1, 2, 3, 4⟩ : Matrix2), ⟨0, 1, -1, 0⟩, ⟨2, 0, 1, 3⟩, ⟨1, 1, 1, 0⟩, ⟨-2, 5, 1, -3⟩], det (transpose M) = det M
#expect_true "(1 2 / 3 4)(0 1 / 1 0) = (2 1 / 4 3)" unfolding mul :
  (mul ⟨1, 2, 3, 4⟩ ⟨0, 1, 1, 0⟩).a = 2 ∧ (mul ⟨1, 2, 3, 4⟩ ⟨0, 1, 1, 0⟩).b = 1 ∧ (mul ⟨1, 2, 3, 4⟩ ⟨0, 1, 1, 0⟩).c = 4 ∧ (mul ⟨1, 2, 3, 4⟩ ⟨0, 1, 1, 0⟩).d = 3
#expect_true "shear k · shear l = shear (k + l)" unfolding mul shear :
  ∀ k ∈ Finset.Icc (-3 : ℤ) 3, ∀ l ∈ Finset.Icc (-3 : ℤ) 3, (mul (shear k) (shear l)).b = k + l ∧ (mul (shear k) (shear l)).a = 1 ∧ (mul (shear k) (shear l)).c = 0
#expect_true "det (M N) = det M · det N on sample matrices" unfolding det mul :
  ∀ M ∈ [(⟨1, 2, 3, 4⟩ : Matrix2), ⟨0, 1, -1, 0⟩, ⟨2, 0, 1, 3⟩, ⟨1, 1, 1, 0⟩, ⟨-2, 5, 1, -3⟩], ∀ N ∈ [(⟨1, 2, 3, 4⟩ : Matrix2), ⟨0, 1, -1, 0⟩, ⟨2, 0, 1, 3⟩, ⟨1, 1, 1, 0⟩, ⟨-2, 5, 1, -3⟩], det (mul M N) = det M * det N
#expect_false "M N = N M for all sample matrices (matrices do not commute)" unfolding mul :
  ∀ M ∈ [(⟨1, 2, 3, 4⟩ : Matrix2), ⟨0, 1, -1, 0⟩, ⟨2, 0, 1, 3⟩, ⟨1, 1, 1, 0⟩, ⟨-2, 5, 1, -3⟩], ∀ N ∈ [(⟨1, 2, 3, 4⟩ : Matrix2), ⟨0, 1, -1, 0⟩, ⟨2, 0, 1, 3⟩, ⟨1, 1, 1, 0⟩, ⟨-2, 5, 1, -3⟩], (mul M N).a = (mul N M).a ∧ (mul M N).b = (mul N M).b

#level_report
