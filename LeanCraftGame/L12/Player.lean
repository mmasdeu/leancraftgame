/-
# ¬ and the order of quantifiers

*When the Prover refutes `FnHasUb f`, it hands back `¬ FnHasUb f` with the negation
pushed inwards. Noor wants everyone to read those by hand, and to stop confusing "bounded"
with "every term is below something".*

`¬ P` (type `\not`) means "not `P`". To read a negated statement, **push the negation
inwards**, flipping each quantifier it passes:

* `¬ ∀ x, P x` is `∃ x, ¬ P x` (a counterexample exists);
* `¬ ∃ x, P x` is `∀ x, ¬ P x`;
* `¬ (a ≤ b)` is `b < a`.

For example, `¬ ∀ x, 0 ≤ f x` becomes `∃ x, ¬ (0 ≤ f x)`, then `∃ x, f x < 0`: some
value is negative. Mathlib's `push_neg` does this, and the Prover prints its results that
way.

## The order of quantifiers

In `∀ a, ∃ x, …`, `x` may depend on `a`. In `∃ x, ∀ a, …`, one `x` must work for every
`a`. Over the reals:

* `∀ x, ∃ y, x < y` is true: for each `x`, take `y = x + 1`;
* `∃ y, ∀ x, x < y` is false: no real is above all reals, itself included.

## Your task

`FnUb` (level 8) and `FnHasUb` (level 9) are in the template. Write these definitions with
the negation pushed all the way in: no `¬` in front of a quantifier, and no `¬ (_ ≤ _)`.

* `NotFnUb f a`: `a` is *not* an upper bound of `f`.
* `NoUpperBound f`: `f` has *no* upper bound.
* `NotMonotone f`: `f` is *not* monotone, in the sense of `MonotoneFn` from level 8:
  `∀ {a b : ℝ}, a ≤ b → f a ≤ f b`.
* `BoundedSeq u`: the sequence `u : ℕ → ℕ` is bounded (above).
-/
namespace L12

def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x ≤ a
def FnHasUb (f : ℝ → ℝ) : Prop := ∃ a, FnUb f a

def NotFnUb (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

def NoUpperBound (f : ℝ → ℝ) : Prop := sorry

def NotMonotone (f : ℝ → ℝ) : Prop := sorry

def BoundedSeq (u : ℕ → ℕ) : Prop := sorry

end L12
