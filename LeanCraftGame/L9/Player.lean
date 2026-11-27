/-
# ∃

*`FnUb f a` from level 8 names one particular bound; most of the time Noor only cares
that **some** bound exists. Meanwhile Sam has written "`f` takes both signs" with a
single `∃`, a statement that no function satisfies.*

With the `FnUb` of level 8 (given in the template), "`f` has an upper bound" reads:

```lean
def FnHasUb (f : ℝ → ℝ) : Prop :=
  ∃ a, FnUb f a
```

"there is an `a` such that `a` is an upper bound of `f`". To show an `∃` statement you
give a **witness**: for `fun x ↦ min x 3`, the witness `3` works, and so does `100`.

## The scope of ∃

`∃ x, P x ∧ Q x` says that **one** `x` satisfies both `P` and `Q`.
`(∃ x, P x) ∧ (∃ x, Q x)` says that some `x` satisfies `P` and some, possibly
different, `x` satisfies `Q`. The brackets decide. "`f` takes a positive value and a
negative value" is the second kind: no single `x` can make `f x` both positive and
negative.

The scope of `∃` (and `∀`) extends **as far right as possible**: in
`∃ x, P x ∧ Q x`, both `P` and `Q` are under the quantifier.

## Your task

`FnUb` is given, as you wrote it in level 8. Write:

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
