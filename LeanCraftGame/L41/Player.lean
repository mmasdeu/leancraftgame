/-
# Endomorphisms

*The quarter turn of level 39 sends no nonzero vector of the real plane to a multiple of
itself. Over ℂ it does: its eigenvalues are `i` and `-i`, the `i` of the Gaussian
integers. Noor wants the theorem behind this stated, with every hypothesis it needs, before
the Prover is handed it.*

Linear maps from a space to itself are called **endomorphisms**:

```lean
abbrev Module.End (R : Type*) (M : Type*) [Semiring R] [AddCommMonoid M] [Module R M] :=
  M →ₗ[R] M
```

They can be composed (`f * g` is `f ∘ g`) and added, so `Module.End K V` is a ring.
Its vocabulary:

```lean
#check (Module.End.eigenspace f μ : Submodule K V)   -- {x | f x = μ • x}
def Module.End.HasEigenvector (f : End R M) (μ : R) (x : M) : Prop :=
  x ∈ eigenspace f μ ∧ x ≠ 0
def Module.End.HasEigenvalue (f : End R M) (a : R) : Prop :=
  eigenspace f a ≠ ⊥
#check (LinearMap.det f : K)                         -- the determinant
#check (minpoly K f : K[X])                          -- the minimal polynomial
```

Read `HasEigenvector` carefully: `x ≠ 0` is part of the definition, since `f 0 = μ • 0`
for every `μ`. And `HasEigenvalue f a` says the eigenspace is not the zero subspace `⊥`.

## A theorem to state

Mathlib proves that an endomorphism of a finite-dimensional complex vector space has an
eigenvalue. Every hypothesis matters:

* over `ℝ` the quarter turn of the plane has no eigenvalue (no line is mapped to itself);
* on the zero space `{0}` there are no nonzero vectors, hence no eigenvectors: the space
  must be `Nontrivial`, that is, have two different elements;
* in infinite dimension there are counterexamples too.

A type-class hypothesis is written in square brackets, like an instance argument of a
Mathlib theorem: `[FiniteDimensional ℂ V] [Nontrivial V]`.

## Matrices

For a matrix, an eigenpair can be checked by hand: `A *ᵥ v = c • v` with `v ≠ 0`, where
`A *ᵥ v` is `A.mulVec v`.

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
