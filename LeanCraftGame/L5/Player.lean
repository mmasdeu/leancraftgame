/-
# Stating theorems

*Time to write for the library. Noor's list starts with AM-GM. With `square` and `am` from
level 2 it reads `a * b ≤ square (am a b)`, and expanding the square gives
`2 * a * b ≤ a ^ 2 + b ^ 2`. The Prover will prove whatever you write, so the referee
checks that you wrote what was asked.*

## The `statement` command

A Mathlib theorem has a name, **binders** (variables and hypotheses, before the colon) and
a **conclusion** (after the colon):

```lean
theorem add_pos {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : 0 < a + b := …
```

This game adds `statement`, a theorem without its proof. Here it is with `am` from level 2,
restated so the file has it:

```lean
def am (a b : ℝ) : ℝ := (a + b) / 2

statement am_pos {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : 0 < am a b
```

It says: for all reals `a` and `b`, if `0 < a` and `0 < b`, then `0 < am a b`.

* `(a b : ℝ)`: explicit variables. A user supplies them: `am_pos 2 3 …`.
* `{a b : ℝ}`: implicit variables. Lean works them out from the hypotheses, so a user
  writes `am_pos h₁ h₂`. Logically, `( )` and `{ }` both mean "for all".
* `(ha : 0 < a)`: a **hypothesis**, named `ha` so a proof can refer to it. The statement
  says "*if* `0 < a` then …".
* After the last colon: the conclusion.

So `statement foo (x : ℝ) (h : 0 ≤ x) : P x` is the proposition `∀ x : ℝ, 0 ≤ x → P x`.
You could also write it that way: `statement foo : ∀ x : ℝ, 0 ≤ x → P x`.

## How the referee reads your statement

The referee compares your statement with the intended one: same variables, same
hypotheses, same conclusion, same order. It allows harmless differences (variable names,
`b ≥ a` for `a ≤ b`, `a * b` for `b * a`, the sides of an `=` swapped). If your statement
is false, it shows a counterexample. No proof can tell two true statements apart, so a
statement that is true but different gets ❓, not ✅.

## Your task

State the five facts below. Use the names given, and `ℝ` for every variable.

1. `sq_add`: for all reals `a` and `b`, `(a + b)² = a² + 2ab + b²`.
2. `two_mul_le`: for all reals `a` and `b`, `2ab ≤ a² + b²` (two-variable AM-GM).
3. `abs_mul_le`: for all reals `a` and `b`, `|ab| ≤ (a² + b²) / 2`.
4. `min_comm'`: for all reals `a` and `b`, `min a b = min b a`.
5. `max_assoc'`: for all reals `a`, `b`, `c`, `max a (max b c) = max (max a b) c`.

Write `x²` as `x ^ 2`. Write `|x|` as `|x|` (type `\|` or the key itself).
-/
namespace L5

statement sq_add : sorry

statement two_mul_le : sorry

statement abs_mul_le : sorry

statement min_comm' : sorry

statement max_assoc' : sorry

end L5
