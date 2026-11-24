/- Hidden test battery for Level Declaring a structure. -/
import LeanCraftGame.Referee
import LeanCraftGame.L44.Player

open L44

#no_sorry I
#no_sorry z34
#no_sorry normSq
#no_sorry conjugate
#no_sorry toPoint
#level_start "Declaring a structure"

#expect_true "the first field of a GaussInt is re, the second im" :
  (GaussInt.mk 3 4).re = 3 ∧ (GaussInt.mk 3 4).im = 4
#expect_true "I = 0 + 1·i" unfolding I :
  I.re = 0 ∧ I.im = 1
#expect_true "z34 = 3 + 4i" unfolding z34 :
  z34.re = 3 ∧ z34.im = 4
#expect_true "normSq z34 = 25" unfolding normSq z34 :
  normSq z34 = 25
#expect_true "normSq I = 1" unfolding normSq I :
  normSq I = 1
#expect_true "normSq (2 - 3i) = 13" unfolding normSq :
  normSq ⟨2, -3⟩ = 13
#expect_true "conjugate z34 = 3 - 4i" unfolding conjugate z34 :
  (conjugate z34).re = 3 ∧ (conjugate z34).im = -4
#expect_true "conjugating twice gives back z (all |a|, |b| ≤ 3)" unfolding conjugate :
  ∀ a ∈ Finset.Icc (-3 : ℤ) 3, ∀ b ∈ Finset.Icc (-3 : ℤ) 3, (conjugate (conjugate ⟨a, b⟩)).re = a ∧ (conjugate (conjugate ⟨a, b⟩)).im = b
#expect_true "normSq (conjugate z) = normSq z (all |a|, |b| ≤ 3)" unfolding normSq conjugate :
  ∀ a ∈ Finset.Icc (-3 : ℤ) 3, ∀ b ∈ Finset.Icc (-3 : ℤ) 3, normSq (conjugate ⟨a, b⟩) = normSq ⟨a, b⟩
#expect_true "toPoint z34 is the point (3, 4)" unfolding toPoint z34 :
  (toPoint z34).x = 3 ∧ (toPoint z34).y = 4

#level_report
