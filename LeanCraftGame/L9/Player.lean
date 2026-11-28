/-
# ∃

*`FnUb f a` from level 8 names one bound. Usually Noor only cares that some bound exists.
Meanwhile Sam wrote "`f` takes both signs" with a single `∃`, and no function satisfies it.*

`∃ x, P x` says "there is an `x` with `P x`". For example, "`f` has a zero":

```lean
def HasZero (f : ℝ → ℝ) : Prop :=
  ∃ x, f x = 0
```

To show an `∃` statement, you give a **witness**. For `fun x ↦ 2 * x - 6`, the witness is
`3`. A definition can also use earlier ones: `FnUb` and `FnLb` from level 8 are given in
the template.

## The scope of ∃

`∃ x, P x ∧ Q x` says one `x` satisfies both `P` and `Q`. `(∃ x, P x) ∧ (∃ x, Q x)` says
some `x` satisfies `P` and some `x`, maybe another, satisfies `Q`. "Some natural number is
even and some is odd" is the second kind: no number is both.

The scope of `∃` (and `∀`) reaches as far right as possible, so in `∃ x, P x ∧ Q x` both
`P` and `Q` are under it.

## Your task

Write:

* `FnHasUb f`: `f` has an upper bound; `FnHasLb f`: `f` has a lower bound;
* `bound`: a number that is an upper bound of `fun x ↦ min x 3` (a witness, of type `ℝ`);
* `root`: a zero of `x ↦ x² - 4x + 4` (a witness);
* `TakesBothSigns f`: `f` takes a positive value and also a negative value.
-/
namespace L9

def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x ≤ a
def FnLb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, a ≤ f x

def FnHasUb (f : ℝ → ℝ) : Prop := sorry

def FnHasLb (f : ℝ → ℝ) : Prop := sorry

def bound : ℝ := sorry

def root : ℝ := sorry

def TakesBothSigns (f : ℝ → ℝ) : Prop := sorry

end L9
