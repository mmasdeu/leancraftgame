/-
# ∧, ∨ and ↔

*Noor wants three characterisations from Mathlib restated for the project, as warm-up,
and one new definition: "`f` has a zero in `[a, b]`". Sam's draft of that one holds
for every function, zeros or not. The connectives explain why.*

* `P ∧ Q`: both. For example, `x < y` is the same as `x ≤ y ∧ x ≠ y`.
* `P ∨ Q`: at least one. For example, `x ≤ |y|` holds exactly when `x ≤ y ∨ x ≤ -y`.
* `P ↔ Q`: `P` and `Q` say the same thing; Mathlib states characterisations this way,
  such as `abs_le : |a| ≤ b ↔ -b ≤ a ∧ a ≤ b`. With it, the bound
  `FnUb (fun x ↦ |f x|) a` of level 8 unpacks into `∀ x, -a ≤ f x ∧ f x ≤ a`: an upper
  bound and a lower bound at once.

## Precedence

From tightest to loosest: `¬`, then `∧`, then `∨`, then `→` and `↔`. So
`P ∧ Q → R` is `(P ∧ Q) → R`, and `¬ P ∨ Q` is `(¬ P) ∨ Q`.

## The trap: `→` under `∃`

"`f` has a zero in `[a, b]`" is `∃ x, a ≤ x ∧ x ≤ b ∧ f x = 0`: one `x` that satisfies
all three. Sam wrote `∃ x, a ≤ x ∧ x ≤ b → f x = 0`, which is a different
statement: it is true as soon as some `x` lies *outside* `[a, b]`, because an implication
with a false hypothesis is true. Under `∀`, use `→`; under `∃`, use `∧`.

## Your task

State the three characterisations, for all reals `x` and `y`:

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
