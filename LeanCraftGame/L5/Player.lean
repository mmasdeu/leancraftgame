/-
# Stating theorems

*Time to write for the library. Noor's first list starts with AM-GM itself: with the
`square` and `am` of level 2, it reads `a * b ≤ square (am a b)`, and expanding the
square turns it into `2 * a * b ≤ a ^ 2 + b ^ 2`. You write the statements; the
Prover will prove whatever you write, so the referee checks that you wrote what was asked.*

## The `statement` command

A theorem in Mathlib has a name, **binders** (the variables and hypotheses, before the
colon) and a **conclusion** (after the colon):

```lean
theorem add_pos {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : 0 < a + b := …
```

This game adds a command that is a theorem without its proof. Here it is with the `am`
of level 2, restated so that the file has it:

```lean
def am (a b : ℝ) : ℝ := (a + b) / 2

statement am_pos {a b : ℝ} (ha : 0 < a) (hb : 0 < b) : 0 < am a b
```

It names the proposition "for all reals `a` and `b`, if `0 < a` and `0 < b`, then
`0 < am a b`". The pieces:

* `(a b : ℝ)`: **explicit** variables. A user of the theorem supplies them:
  `am_pos 2 3 …`.
* `{a b : ℝ}`: **implicit** variables. Lean works them out from the hypotheses, so a
  user writes `am_pos h₁ h₂`. Logically, `( )` and `{ }` say the same: "for all".
* `(ha : 0 < a)`: a **hypothesis**, named `ha` so that a proof can refer to it. A
  hypothesis is an assumption: the statement says "*if* `0 < a` then …".
* After the last colon: the **conclusion**.

So `statement foo (x : ℝ) (h : 0 ≤ x) : P x` is the proposition `∀ x : ℝ, 0 ≤ x → P x`,
and you could also write it that way, after the colon: `statement foo : ∀ x : ℝ, 0 ≤ x → P x`.

## How the referee reads your statement

The referee compares your statement with the one intended: the same variables, the same
hypotheses and the same conclusion, in the same order. It allows harmless differences
(variable names, `b ≥ a` for `a ≤ b`, `a * b` for `b * a`, sides of an `=` swapped), and
when your statement is false it shows you a counterexample. Two **true** statements can
never be told apart by a proof, so a statement that is true but different gets ❓, not ✅.

## Your task

State the five facts below. Use the names given, and `ℝ` for every variable.

1. `sq_add`: for all reals `a` and `b`, `(a + b)² = a² + 2ab + b²`.
2. `two_mul_le`: for all reals `a` and `b`, `2ab ≤ a² + b²` (the two-variable AM-GM).
3. `abs_mul_le`: for all reals `a` and `b`, `|ab| ≤ (a² + b²) / 2`.
4. `min_comm'`: for all reals `a` and `b`, `min a b = min b a`.
5. `max_assoc'`: for all reals `a`, `b`, `c`, `max a (max b c) = max (max a b) c`.

`x²` is written `x ^ 2`, and `|x|` is written `|x|` (type `\|` or the key itself).
-/
namespace L5

statement sq_add : sorry

statement two_mul_le : sorry

statement abs_mul_le : sorry

statement min_comm' : sorry

statement max_assoc' : sorry

end L5
