/- Hidden test battery for Level 41: Endomorphisms. -/
import LeanCraftGame.Referee
import LeanCraftGame.L36.Player

open L36

#no_sorry q1
#no_sorry q2
#no_sorry q3
#no_sorry q4
#no_sorry exists_eig
#no_sorry ev₁
#no_sorry vec₁
#no_sorry ev₂
#no_sorry vec₂
#level_start "Endomorphisms"

#expect_choice "Question 1: what `Module.End K V` is" : q1 = 2
#expect_choice "Question 2: can the zero vector be an eigenvector?" : q2 = false
#expect_choice "Question 3: the type of `minpoly K f`" : q3 = 1
#expect_choice "Question 4: does the theorem stay true over ℝ?" : q4 = false

#expect_equiv "exists_eig states the theorem, with every hypothesis" :
  L36.exists_eig ↔ ∀ {V : Type} [AddCommGroup V] [Module ℂ V] [FiniteDimensional ℂ V]
    [Nontrivial V] (f : Module.End ℂ V), ∃ c : ℂ, f.HasEigenvalue c
  using fun f => Module.End.exists_eigenvalue f

#expect_true "A *ᵥ vec₁ = ev₁ • vec₁" unfolding A ev₁ vec₁ : A.mulVec vec₁ = ev₁ • vec₁
#expect_true "vec₁ is not the zero vector" unfolding vec₁ : vec₁ ≠ 0
#expect_true "A *ᵥ vec₂ = ev₂ • vec₂" unfolding A ev₂ vec₂ : A.mulVec vec₂ = ev₂ • vec₂
#expect_true "vec₂ is not the zero vector" unfolding vec₂ : vec₂ ≠ 0
#expect_true "ev₁ < ev₂" unfolding ev₁ ev₂ : ev₁ < ev₂

#level_report
