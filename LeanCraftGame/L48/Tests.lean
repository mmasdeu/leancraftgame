/- Hidden test battery for Level 48: Derivatives. -/
import LeanCraftGame.Referee
import LeanCraftGame.L48.Player

theorem L48T.sq_ref : HasDerivAt (fun x : ℝ => x ^ 2) 6 3 := by
  have := hasDerivAt_pow 2 (3 : ℝ); norm_num at this; exact this

-- Facts the referee may use: Mathlib's derivative of `|x|`, and `HasDerivAt` in terms of `deriv`.
@[simp] theorem L48T.deriv_abs' (x : ℝ) : deriv (fun y : ℝ => |y|) x = SignType.sign x :=
  deriv_abs x
@[simp] theorem L48T.hasDerivAt_iff' {f : ℝ → ℝ} {f' x : ℝ} :
    HasDerivAt f f' x ↔ DifferentiableAt ℝ f x ∧ deriv f x = f' := by
  constructor
  · intro h; exact ⟨h.differentiableAt, h.deriv⟩
  · rintro ⟨h₁, rfl⟩; exact h₁.hasDerivAt

#no_sorry L48.d3
#no_sorry L48.sq_hasDeriv
#no_sorry L48.rolle
#no_sorry L48.mvt
#no_sorry L48.q1
#no_sorry L48.q2
#level_start "Derivatives"

#expect_true "In Mathlib, deriv (fun x => |x|) 0 = 0" :
  deriv (fun x : ℝ => |x|) 0 = 0
#expect_true "d3 is the derivative of x ↦ x³ at 2" unfolding L48.d3 :
  L48.d3 = 12
#expect_equiv "sq_hasDeriv says: x ↦ x² has derivative 6 at 3" :
  L48.sq_hasDeriv ↔ HasDerivAt (fun x : ℝ => x ^ 2) 6 3
  using L48T.sq_ref
#expect_equiv "rolle is Rolle's theorem, with Mathlib's hypotheses" :
  L48.rolle ↔ ∀ (f : ℝ → ℝ) (a b : ℝ), a < b → ContinuousOn f (Set.Icc a b) → f a = f b →
    ∃ c ∈ Set.Ioo a b, deriv f c = 0
  using fun _ _ _ => exists_deriv_eq_zero
#expect_equiv "mvt is the mean value theorem" :
  L48.mvt ↔ ∀ (f : ℝ → ℝ) (a b : ℝ), a < b → ContinuousOn f (Set.Icc a b) →
    DifferentiableOn ℝ f (Set.Ioo a b) → ∃ c ∈ Set.Ioo a b, deriv f c = (f b - f a) / (b - a)
  using fun f _ _ => exists_deriv_eq_slope f
#expect_choice "Question 1: why Mathlib's Rolle needs no differentiability" : L48.q1 = 1
#expect_choice "Question 2: the order of the arguments of HasDerivAt" : L48.q2 = false

#level_report
