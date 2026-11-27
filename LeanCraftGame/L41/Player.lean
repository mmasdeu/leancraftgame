/-
# Endomorphisms

*The quarter turn of level 39 sends no nonzero vector of the real plane to a multiple of
itself. Over ℂ it does: its eigenvalues are `i` and `-i`. Noor wants the theorem behind
this stated, with every hypothesis it needs.*

Linear maps from a space to itself are **endomorphisms**:

```lean
abbrev Module.End (R : Type*) (M : Type*) [Semiring R] [AddCommMonoid M] [Module R M] :=
  M →ₗ[R] M
```

You can compose them (`f * g` is `f ∘ g`) and add them, so `Module.End K V` is a ring.
The vocabulary:

```lean
#check (Module.End.eigenspace f μ : Submodule K V)   -- {x | f x = μ • x}
def Module.End.HasEigenvector (f : End R M) (μ : R) (x : M) : Prop :=
  x ∈ eigenspace f μ ∧ x ≠ 0
def Module.End.HasEigenvalue (f : End R M) (a : R) : Prop :=
  eigenspace f a ≠ ⊥
#check (LinearMap.det f : K)                         -- the determinant
#check (minpoly K f : K[X])                          -- the minimal polynomial
```

`x ≠ 0` is part of `HasEigenvector`, since `f 0 = μ • 0` for every `μ`. `HasEigenvalue f a`
says the eigenspace isn't the zero subspace `⊥`.

## A theorem to state

Mathlib proves that an endomorphism of a finite-dimensional complex vector space has an
eigenvalue. Every hypothesis matters:

* Over `ℝ`, the quarter turn of the plane has no eigenvalue.
* The zero space `{0}` has no eigenvectors. The space must be `Nontrivial`: it has two
  different elements.
* In infinite dimension there are counterexamples too.

Type-class hypotheses go in square brackets: `[FiniteDimensional ℂ V] [Nontrivial V]`.

## Matrices

For a matrix, check an eigenpair by hand: `A *ᵥ v = c • v` with `v ≠ 0`, where `A *ᵥ v`
is `A.mulVec v`.

## Your task

1. Answer the questions below the lesson.
2. State `exists_eig`: for every type `V : Type` with `[AddCommGroup V] [Module ℂ V]`,
   finite-dimensional over `ℂ` and nontrivial, every `f : Module.End ℂ V` has some
   eigenvalue `c : ℂ`. Write the binders in this order.
3. Give the two eigenvalues of `A = !![2, 1; 0, 3]` (`ev₁ < ev₂`), each with an
   eigenvector.
-/
import Mathlib.LinearAlgebra.Eigenspace.Triangularizable
import Mathlib.Analysis.Complex.Polynomial.Basic

namespace L41

def q1 : Fin 4 := sorry
def q2 : Bool := sorry
def q3 : Fin 4 := sorry
def q4 : Bool := sorry

statement exists_eig : sorry

def A : Matrix (Fin 2) (Fin 2) ℚ := !![2, 1; 0, 3]

def ev₁ : ℚ := sorry
def vec₁ : Fin 2 → ℚ := sorry
def ev₂ : ℚ := sorry
def vec₂ : Fin 2 → ℚ := sorry

end L41
