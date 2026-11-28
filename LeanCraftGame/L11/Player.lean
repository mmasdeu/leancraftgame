/-
# ∧, ∨ and ↔

*Noor wants three Mathlib characterisations restated as a warm-up, and one new
definition: "`f` has a zero in `[a, b]`". Sam's draft of it holds for every function.*

* `P ∧ Q` (type `\and`): both. `0 < x ∧ x < 1` says `x` lies in `(0, 1)`.
* `P ∨ Q` (type `\or`): at least one. `x < 0 ∨ 1 < x` says `x` lies outside `[0, 1]`.
* `P ↔ Q` (type `\iff`): "`P` if and only if `Q`". For example
  `x ^ 2 = 1 ↔ x = 1 ∨ x = -1`.

## Precedence

From tightest to loosest: `¬`, then `∧`, then `∨`, then `→` and `↔`. So `P ∧ Q → R` is
`(P ∧ Q) → R`, and `¬ P ∨ Q` is `(¬ P) ∨ Q`.

## `→` and `∧` under quantifiers

`P → Q` is false only when `P` is true and `Q` is false. So the two quantifiers want
different connectives: "every `x ≥ 0` has `f x ≤ x`" is `∀ x, 0 ≤ x → f x ≤ x`, while
"some `x ≥ 0` has `f x ≤ x`" is `∃ x, 0 ≤ x ∧ f x ≤ x`.

## Your task

State the three characterisations for all reals `x` and `y`, binders before the colon as
in level 5: `statement lt_iff' (x y : ℝ) : …`. The prime keeps the names apart from
Mathlib's own. Each right-hand side joins the two given inequalities with `∧` or `∨`:
decide which.

1. `lt_iff'`: `x < y` in terms of `x ≤ y` and `x ≠ y`;
2. `abs_lt'`: `|x| < y` in terms of `-y < x` and `x < y`;
3. `le_abs'`: `x ≤ |y|` in terms of `x ≤ y` and `x ≤ -y`.

Then define `HasZeroIn f a b`: `f` has a zero in the closed interval `[a, b]`.
-/
namespace L11

statement lt_iff' : sorry

statement abs_lt' : sorry

statement le_abs' : sorry

def HasZeroIn (f : ℝ → ℝ) (a b : ℝ) : Prop := sorry

end L11
