/-
# ∃

*`FnUb f a` from level 8 names one bound. Usually Noor only cares that some bound exists.
Meanwhile Sam wrote "`f` takes both signs" with a single `∃`, and no function satisfies it.*

With `FnUb` (given in the template), "`f` has an upper bound" reads:

```lean
def FnHasUb (f : ℝ → ℝ) : Prop :=
  ∃ a, FnUb f a
```

"There is an `a` that is an upper bound of `f`." To show an `∃` statement, you give a
**witness**. For `fun x ↦ min x 3`, the witness `3` works, and so does `100`.

## The scope of ∃

`∃ x, P x ∧ Q x` says one `x` satisfies both `P` and `Q`. `(∃ x, P x) ∧ (∃ x, Q x)` says
some `x` satisfies `P` and some `x`, maybe another, satisfies `Q`. "`f` takes a positive
value and a negative value" is the second kind: no single `f x` is both.

The scope of `∃` (and `∀`) reaches as far right as possible, so in `∃ x, P x ∧ Q x` both
`P` and `Q` are under it.

## Your task

Write:

* `FnHasUb f`: `f` has an upper bound; `FnHasLb f`: `f` has a lower bound;
* `bound`: an upper bound of `fun x ↦ min x 3` (a witness);
* `root`: a zero of `x ↦ x² - 4x + 4` (a witness);
* `TakesBothSigns f`: `f` takes a positive value and also a negative value.
-/
namespace L9

def FnUb (f : ℝ → ℝ) (a : ℝ) : Prop := ∀ x, f x ≤ a

def FnHasUb (f : ℝ → ℝ) : Prop := sorry

def FnHasLb (f : ℝ → ℝ) : Prop := sorry

def bound : ℝ := sorry

def root : ℝ := sorry

def TakesBothSigns (f : ℝ → ℝ) : Prop := sorry

end L9
