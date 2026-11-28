/-
# Stating theorems

*Noor's list starts with AM-GM for two numbers, `2ab ≤ a² + b²`. The Prover proves
whatever you write, so the referee checks you wrote what was asked.*

## The `statement` command

A theorem has a name, **binders** (variables and hypotheses, before the colon) and a
conclusion (after it):

```lean
theorem add_pos {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : 0 < a + b := …
```

This game adds `statement`, a theorem without its proof. With `am` from level 2:

```lean
def am (a b : ℝ) : ℝ := (a + b) / 2

statement am_pos {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : 0 < am a b
```

It says: for all reals `a` and `b`, if `0 < a` and `0 < b`, then `0 < am a b`.

* `(a b : ℝ)`: explicit variables. A user supplies them: `am_pos 2 3 …`.
* `{a b : ℝ}`: implicit variables. Lean infers them from the hypotheses, so a user writes
  `am_pos h₁ h₂`. Logically, both mean "for all", and either is fine in this level.
* `(ha : 0 < a)`: a hypothesis, named `ha` so a proof can use it. It means "*if* `0 < a`".

## How the referee reads your statement

The referee compares your statement with the intended one: same variables, hypotheses
and conclusion, in the same order. Harmless differences are fine (variable names, `b ≥ a`
for `a ≤ b`, `a * b` for `b * a`, the sides of an `=` swapped). A false statement gets a
counterexample. A proof can't tell two true statements apart, so a true but different
statement gets ❓, not ✅.

## Your task

State the five facts below. Use the names given, and `ℝ` for every variable.

1. `sq_add`: for all reals `a` and `b`, `(a + b)² = a² + 2ab + b²`.
2. `two_mul_le`: for all reals `a` and `b`, `2ab ≤ a² + b²` (two-variable AM-GM).
3. `abs_mul_le`: for all reals `a` and `b`, `|ab| ≤ (a² + b²) / 2`.
4. `min_comm'`: for all reals `a` and `b`, `min a b = min b a`.
5. `max_assoc'`: for all reals `a`, `b`, `c`, `max a (max b c) = max (max a b) c`.

Write `x²` as `x ^ 2`. `|x|` is the absolute value: type it with the bar key on your
keyboard, `|a * b|`. `min a b` and `max a b` are the smaller and the larger of `a` and
`b`.
-/
namespace L7

statement sq_add : sorry

statement two_mul_le : sorry

statement abs_mul_le : sorry

statement min_comm' : sorry

statement max_assoc' : sorry

end L7
