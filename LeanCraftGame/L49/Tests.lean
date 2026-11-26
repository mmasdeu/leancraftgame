/- Hidden test battery for Level 49: Derivatives in normed spaces. -/
import LeanCraftGame.Referee
import LeanCraftGame.L49.Player

-- A fact the referee may use: the derivative of the first coordinate is the projection.
@[simp] theorem L49T.fderiv_fst' (p : ℝ × ℝ) :
    fderiv ℝ (fun q : ℝ × ℝ => q.1) p = ContinuousLinearMap.fst ℝ ℝ ℝ :=
  fderiv_fst

#no_sorry L49.Df
#no_sorry L49.Dg
#no_sorry L49.normPair
#no_sorry L49.q1
#no_sorry L49.q2
#no_sorry L49.q3
#level_start "Derivatives in normed spaces"

#expect_type "Df has the type of a derivative of ℝ × ℝ → ℝ" :
  L49.Df : (ℝ × ℝ → ℝ) → ℝ × ℝ → (ℝ × ℝ →L[ℝ] ℝ)
#expect_true "Df f p is the derivative of f at p: for f (x, y) = x, at (0, 0), in the direction (1, 0), it is 1" unfolding L49.Df :
  L49.Df (fun q => q.1) (0, 0) (1, 0) = 1
#expect_type "Dg has the type of a derivative of ℝ → ℝ × ℝ" :
  L49.Dg : (ℝ → ℝ × ℝ) → ℝ → (ℝ →L[ℝ] ℝ × ℝ)
#expect_true "Dg g t is the derivative of g at t" unfolding L49.Dg :
  ∀ (g : ℝ → ℝ × ℝ) (t : ℝ), L49.Dg g t = fderiv ℝ g t
#expect_true "normPair is Mathlib's norm of (3, -4)" unfolding L49.normPair :
  L49.normPair = ‖((3 : ℝ), (-4 : ℝ))‖
#expect_choice "Question 1: what kind of object fderiv ℝ f x is" : L49.q1 = 2
#expect_choice "Question 2: the explicit arguments of fderiv" : L49.q2 = 1
#expect_choice "Question 3: deriv and fderiv" : L49.q3 = true

#level_report
