/-
# ¬ and the order of quantifiers

*When the Prover refutes `FnHasUb f`, it hands back `¬ FnHasUb f` with the negation
pushed inwards. Noor wants everyone to read those by hand, and to stop confusing "bounded"
with "every term is below something".*

`FnUb` (level 8) and `FnHasUb` (level 9) are in the template. To read `¬ FnHasUb f`,
**push the negation inwards**, flipping each quantifier:

* `¬ ∀ x, P x` is `∃ x, ¬ P x` (a counterexample exists);
* `¬ ∃ x, P x` is `∀ x, ¬ P x`;
* `¬ (a ≤ b)` is `b < a`; `¬ (P ∧ Q)` is `P → ¬ Q`.

So `¬ FnHasUb f` = `¬ ∃ a, ∀ x, f x ≤ a` = `∀ a, ∃ x, ¬ (f x ≤ a)` = `∀ a, ∃ x, a < f x`.
Whatever bound you propose, some value beats it. Mathlib's `push_neg` does this, and you'll
read its output in proofs.

## The order of quantifiers

In `∀ a, ∃ x, …`, `x` may depend on `a`. In `∃ x, ∀ a, …`, one `x` must work for every
`a`. For sequences:

* `∃ M, ∀ n, u n ≤ M`: the sequence is **bounded** (one `M` for all `n`);
* `∀ n, ∃ M, u n ≤ M`: true of every sequence (take `M = u n`).

## Your task

Write the negations pushed inwards: no `¬` in front of a quantifier, and no `¬ (_ ≤ _)`.

* `NotFnUb f a`: `a` is *not* an upper bound of `f`.
* `NoUpperBound f`: `f` has *no* upper bound.
* `NotMonotone f`: `f` is *not* monotone, in the sense of `MonotoneFn` from level 8:
  `∀ {a b : ℝ}, a ≤ b → f a ≤ f b`.
* `BoundedSeq u`: the sequence `u : ℕ → ℕ` is bounded.
-/
namespace L10

def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x ≤ a
def FnHasUb (f : ℝ → ℝ) : Prop := ∃ a, FnUb f a

def NotFnUb (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

def NoUpperBound (f : ℝ → ℝ) : Prop := sorry

def NotMonotone (f : ℝ → ℝ) : Prop := sorry

def BoundedSeq (u : ℕ → ℕ) : Prop := sorry

end L10
