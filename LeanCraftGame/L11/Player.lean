/-
# ∧, ∨ and ↔

MIL §3.4–3.5 combine statements:

* `P ∧ Q`: both. MIL's first example: `x < y` is the same as `x ≤ y ∧ x ≠ y`.
* `P ∨ Q`: at least one. MIL's: `x ≤ |y|` holds exactly when `x ≤ y ∨ x ≤ -y`.
* `P ↔ Q`: `P` and `Q` say the same thing; Mathlib states characterisations this way,
  such as `abs_lt : |a| < b ↔ -b < a ∧ a < b`.

## Precedence

From tightest to loosest: `¬`, then `∧`, then `∨`, then `→` and `↔`. So
`P ∧ Q → R` is `(P ∧ Q) → R`, and `¬ P ∨ Q` is `(¬ P) ∨ Q`.

## The trap: `→` under `∃`

"`f` has a zero in `[a, b]`" is `∃ x, a ≤ x ∧ x ≤ b ∧ f x = 0`: one `x` that satisfies
all three. It is tempting to write `∃ x, a ≤ x ∧ x ≤ b → f x = 0`, which is a different
statement: it is true as soon as some `x` lies *outside* `[a, b]`, because an implication
with a false hypothesis is true. Under `∀`, use `→`; under `∃`, use `∧`.

## Your task

State MIL's three characterisations, for all reals `x` and `y`:

1. `lt_iff'`: `x < y ↔ x ≤ y ∧ x ≠ y`;
2. `abs_lt'`: `|x| < y ↔ -y < x ∧ x < y`;
3. `le_abs'`: `x ≤ |y| ↔ x ≤ y ∨ x ≤ -y`.

Then define `HasZeroIn f a b`: `f` has a zero in the closed interval `[a, b]`.
-/
namespace L11

statement lt_iff' : sorry

statement abs_lt' : sorry

statement le_abs' : sorry

def HasZeroIn (f : ℝ → ℝ) (a b : ℝ) : Prop := sorry

end L11
