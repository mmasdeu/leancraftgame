/- Hidden test battery for Level 30: Gaussian integers. -/
import LeanCraftGame.Referee
import LeanCraftGame.L30.Player

open L30

#no_sorry GaussInt.add
#no_sorry GaussInt.mul
#no_sorry GaussInt.conj
#no_sorry GaussInt.norm
#no_sorry z5
#no_sorry w13
#level_start "Gaussian integers"

#expect_true "(1 + 2i) + (3 - i) = 4 + i" unfolding GaussInt.add :
  (GaussInt.add ⟨1, 2⟩ ⟨3, -1⟩).re = 4 ∧ (GaussInt.add ⟨1, 2⟩ ⟨3, -1⟩).im = 1
#expect_true "i · i = -1" unfolding GaussInt.mul :
  (GaussInt.mul ⟨0, 1⟩ ⟨0, 1⟩).re = -1 ∧ (GaussInt.mul ⟨0, 1⟩ ⟨0, 1⟩).im = 0
#expect_true "(1 + 2i)(2 + 3i) = -4 + 7i" unfolding GaussInt.mul :
  (GaussInt.mul ⟨1, 2⟩ ⟨2, 3⟩).re = -4 ∧ (GaussInt.mul ⟨1, 2⟩ ⟨2, 3⟩).im = 7
#expect_true "the conjugate of 3 + 4i is 3 - 4i" unfolding GaussInt.conj :
  (GaussInt.conj ⟨3, 4⟩).re = 3 ∧ (GaussInt.conj ⟨3, 4⟩).im = -4
#expect_true "the norm of 3 + 4i is 25" unfolding GaussInt.norm : GaussInt.norm ⟨3, 4⟩ = 25
#expect_true "the norm of 1 - 2i is 5" unfolding GaussInt.norm : GaussInt.norm ⟨1, -2⟩ = 5
#expect_true "z5 has norm 5 and w13 has norm 13" unfolding GaussInt.norm z5 w13 :
  z5.norm = 5 ∧ w13.norm = 13
#expect_true "z5 · w13 and z5 · conj w13 write 65 as a sum of two squares in two different ways"
    unfolding GaussInt.mul GaussInt.conj GaussInt.norm z5 w13 :
  (z5.mul w13).norm = 65 ∧ (z5.mul w13.conj).norm = 65 ∧
    (z5.mul w13).re ^ 2 ≠ (z5.mul w13.conj).re ^ 2 ∧ (z5.mul w13).re ^ 2 ≠ (z5.mul w13.conj).im ^ 2
#expect_true "the norm is multiplicative (all coordinates in [-2, 2])" unfolding GaussInt.mul GaussInt.norm :
  ∀ a ∈ Finset.Icc (-2 : ℤ) 2, ∀ b ∈ Finset.Icc (-2 : ℤ) 2, ∀ c ∈ Finset.Icc (-2 : ℤ) 2, ∀ d ∈ Finset.Icc (-2 : ℤ) 2,
    (GaussInt.mul ⟨a, b⟩ ⟨c, d⟩).norm = (GaussInt.norm ⟨a, b⟩) * (GaussInt.norm ⟨c, d⟩)
#expect_true "z · conj z is the norm of z (all coordinates in [-3, 3])" unfolding GaussInt.mul GaussInt.conj GaussInt.norm :
  ∀ a ∈ Finset.Icc (-3 : ℤ) 3, ∀ b ∈ Finset.Icc (-3 : ℤ) 3,
    (GaussInt.mul ⟨a, b⟩ (GaussInt.conj ⟨a, b⟩)).re = GaussInt.norm ⟨a, b⟩ ∧
    (GaussInt.mul ⟨a, b⟩ (GaussInt.conj ⟨a, b⟩)).im = 0

#level_report
