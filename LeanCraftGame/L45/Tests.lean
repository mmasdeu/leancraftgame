/- Hidden test battery for Level Functions on structures. -/
import LeanCraftGame.Referee
import LeanCraftGame.L45.Player

open L45 L45.GaussInt

#no_sorry GaussInt.add
#no_sorry GaussInt.mul
#no_sorry GaussInt.pow
#level_start "Functions on structures"

#expect_true "(1 + 2i) + (3 - i) = 4 + i" unfolding GaussInt.add :
  (GaussInt.add ⟨1, 2⟩ ⟨3, -1⟩).re = 4 ∧ (GaussInt.add ⟨1, 2⟩ ⟨3, -1⟩).im = 1
#expect_true "i · i = -1" unfolding GaussInt.mul :
  (GaussInt.mul ⟨0, 1⟩ ⟨0, 1⟩).re = -1 ∧ (GaussInt.mul ⟨0, 1⟩ ⟨0, 1⟩).im = 0
#expect_true "(2 + i)(2 - i) = 5: the prime 5 splits" unfolding GaussInt.mul :
  (GaussInt.mul ⟨2, 1⟩ ⟨2, -1⟩).re = 5 ∧ (GaussInt.mul ⟨2, 1⟩ ⟨2, -1⟩).im = 0
#expect_true "(1 + 2i)(2 + 3i) = -4 + 7i, and 65 = 4² + 7²" unfolding GaussInt.mul GaussInt.normSq :
  (GaussInt.mul ⟨1, 2⟩ ⟨2, 3⟩).re = -4 ∧ (GaussInt.mul ⟨1, 2⟩ ⟨2, 3⟩).im = 7 ∧ (GaussInt.mul ⟨1, 2⟩ ⟨2, 3⟩).normSq = 65
#expect_true "(1 + 2i)(2 - 3i) = 8 + i, and 65 = 8² + 1²" unfolding GaussInt.mul :
  (GaussInt.mul ⟨1, 2⟩ ⟨2, -3⟩).re = 8 ∧ (GaussInt.mul ⟨1, 2⟩ ⟨2, -3⟩).im = 1
#expect_true "mul is commutative (all coordinates in [-2, 2])" unfolding GaussInt.mul :
  ∀ a ∈ Finset.Icc (-2 : ℤ) 2, ∀ b ∈ Finset.Icc (-2 : ℤ) 2, ∀ c ∈ Finset.Icc (-2 : ℤ) 2, ∀ d ∈ Finset.Icc (-2 : ℤ) 2, (GaussInt.mul ⟨a, b⟩ ⟨c, d⟩).re = (GaussInt.mul ⟨c, d⟩ ⟨a, b⟩).re ∧ (GaussInt.mul ⟨a, b⟩ ⟨c, d⟩).im = (GaussInt.mul ⟨c, d⟩ ⟨a, b⟩).im
#expect_true "The norm is multiplicative (all coordinates in [-2, 2])" unfolding GaussInt.mul GaussInt.normSq :
  ∀ a ∈ Finset.Icc (-2 : ℤ) 2, ∀ b ∈ Finset.Icc (-2 : ℤ) 2, ∀ c ∈ Finset.Icc (-2 : ℤ) 2, ∀ d ∈ Finset.Icc (-2 : ℤ) 2, (GaussInt.mul ⟨a, b⟩ ⟨c, d⟩).normSq = (GaussInt.normSq ⟨a, b⟩) * (GaussInt.normSq ⟨c, d⟩)
#expect_true "z⁰ = 1" unfolding GaussInt.pow :
  (GaussInt.pow ⟨5, 7⟩ 0).re = 1 ∧ (GaussInt.pow ⟨5, 7⟩ 0).im = 0
#expect_true "i⁴ = 1" unfolding GaussInt.pow GaussInt.mul :
  (GaussInt.pow ⟨0, 1⟩ 4).re = 1 ∧ (GaussInt.pow ⟨0, 1⟩ 4).im = 0
#expect_true "(1 + i)⁴ = -4" unfolding GaussInt.pow GaussInt.mul :
  (GaussInt.pow ⟨1, 1⟩ 4).re = -4 ∧ (GaussInt.pow ⟨1, 1⟩ 4).im = 0

#level_report
