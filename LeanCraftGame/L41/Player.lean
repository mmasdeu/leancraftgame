/-
# Endomorphisms

*Noor wants a classic theorem stated, with every hypothesis it needs: an endomorphism of a
finite-dimensional complex vector space has an eigenvalue. The quarter turn of level 39
is a good test case.*

Linear maps from a space to itself are **endomorphisms** (`K` and `V` as in level 39):

```lean
abbrev Module.End (R : Type*) (M : Type*) [Semiring R] [AddCommMonoid M] [Module R M] :=
  M →ₗ[R] M
```

`abbrev` is a `def` that Lean unfolds freely. You can compose endomorphisms (`f * g` is
`f ∘ g`) and add them, so `Module.End K V` is a ring. The vocabulary:

```lean
#check (Module.End.eigenspace f μ : Submodule K V)   -- {x | f x = μ • x}
def Module.End.HasEigenvector (f : Module.End R M) (μ : R) (x : M) : Prop :=
  x ∈ eigenspace f μ ∧ x ≠ 0
def Module.End.HasEigenvalue (f : Module.End R M) (a : R) : Prop :=
  eigenspace f a ≠ ⊥
#check (minpoly K f : K[X])   -- the minimal polynomial: monic, of least degree, kills f
```

`HasEigenvalue f a` says the eigenspace isn't the zero subspace `⊥`.

## A theorem to state

Mathlib proves that an endomorphism of a finite-dimensional complex vector space has an
eigenvalue. Every hypothesis matters. For example, the zero space `{0}` has no
eigenvectors, so the space must be `Nontrivial`: it has two different elements.

Type-class hypotheses go in square brackets: `[FiniteDimensional ℂ V]` (`V` has a finite
basis over `ℂ`, the complex numbers) and `[Nontrivial V]`.

## Matrices

`!![2, 1; 0, 3]` is the 2 × 2 matrix with rows `2 1` and `0 3`. `A *ᵥ v` (or
`A.mulVec v`) is the matrix times the column vector `v`. For example
`!![1, 2; 3, 4] *ᵥ ![1, 0] = ![1, 3]`. An eigenpair is `c` and `v ≠ 0` with
`A *ᵥ v = c • v`.

## Your task

1. Answer the questions below the lesson.
2. State `exists_eig`: for every type `V : Type` with `[AddCommGroup V] [Module ℂ V]`,
   finite-dimensional over `ℂ` and nontrivial, every `f : Module.End ℂ V` has some
   eigenvalue `c : ℂ`. Write the binders in this order: `{V : Type}` (implicit), the four
   instances, then `(f : Module.End ℂ V)`.
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
