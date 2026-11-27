/-
# ¬ and the order of quantifiers

*The Prover's reports are full of negations: whenever it refutes `FnHasUb f`, it hands
back `¬ FnHasUb f`, already pushed inwards. Noor wants everyone to read those by hand,
and to stop confusing "bounded" with "every term is below something".*

`FnUb` (level 8) and `FnHasUb` (level 9) are given in the template. To work with
`¬ FnHasUb f` ("`f` has no upper bound") you first **push the negation inwards**,
turning each quantifier over:

* `¬ ∀ x, P x` is `∃ x, ¬ P x` (a counterexample exists);
* `¬ ∃ x, P x` is `∀ x, ¬ P x`;
* `¬ (a ≤ b)` is `b < a`; `¬ (P ∧ Q)` is `P → ¬ Q`.

So `¬ FnHasUb f` = `¬ ∃ a, ∀ x, f x ≤ a` = `∀ a, ∃ x, ¬ (f x ≤ a)` = `∀ a, ∃ x, a < f x`:
"whatever bound you propose, some value exceeds it". Mathlib's tactic `push_neg` does
this mechanically, and its output is what you will read in proofs, so you should be able
to do it by hand.

## The order of quantifiers

`∀ a, ∃ x, …` and `∃ x, ∀ a, …` are different statements. In the first, `x` may depend
on `a`; in the second, one `x` must work for every `a`. For sequences:

* `∃ M, ∀ n, u n ≤ M`: the sequence is **bounded** (one `M` for all `n`);
* `∀ n, ∃ M, u n ≤ M`: every term is below *some* number, which is true of every
  sequence (take `M = u n`).

## Your task

Write the negations **pushed inwards**: no `¬` in front of a quantifier, and no `¬ (_ ≤ _)`.

* `NotFnUb f a`: `a` is *not* an upper bound of `f`.
* `NoUpperBound f`: `f` has *no* upper bound.
* `NotMonotone f`: `f` is *not* monotone (in the sense of `MonotoneFn` from level 8:
  `∀ {a b : ℝ}, a ≤ b → f a ≤ f b`).
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
