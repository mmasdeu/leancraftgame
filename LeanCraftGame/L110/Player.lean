/-
# Continuity

"Limits" gave you the shape `∀ ε > 0, ∃ N, …`. Continuity of a function has the
same shape, but the second quantifier is a real number `δ` (type `\delta`) that
measures how close `x` must be to a point `a`.

* A real function is `f : ℝ → ℝ`. You will see `fun x => 2 * x`, and also step
  functions such as `fun x => if x ≤ 0 then 0 else 1`.
* `|x - a| < δ` says that `x` is within `δ` of `a`.

A function `f` is **continuous at** `a` when: for every `ε > 0` there is a
`δ > 0` such that every `x` within `δ` of `a` has `f x` within `ε` of `f a`.

The level has two definitions. First the *inner* part of the sentence, for one
fixed `ε` and one fixed `δ`: "`δ` is a good choice for `ε`". Then continuity
itself, built on top of it. The referee tests the first one on concrete numbers,
so it also checks the details that make the second one right.

```lean
-- the worked example: f never leaves the interval from -M to M
def BoundedBy (f : ℝ → ℝ) (M : ℝ) : Prop := ∀ x, |f x| ≤ M
```

## What can go wrong

* A `δ` that is `0` (or negative) is not allowed: nothing is within distance
  `0`, so the condition would hold for free.
* The distance is `|x - a|`, from `a`, not `|x|`; and `f x` is compared with
  `f a`, not with `a`.
* `<` is not `≤`: a jump of exactly `ε` is not "within `ε`".
* `ε` ranges over positive numbers only, and `δ` may depend on `ε`.

## Your task

`BoundedBy` is done. Define `IsDeltaFor f a ε δ`, then `ContAt f a`.
-/
namespace L110

-- f stays between -M and M (already done)
def BoundedBy (f : ℝ → ℝ) (M : ℝ) : Prop := ∀ x, |f x| ≤ M

-- δ is a good choice for ε at a: δ > 0, and every x within δ of a
-- has f x within ε of f a
def IsDeltaFor (f : ℝ → ℝ) (a ε δ : ℝ) : Prop := sorry

-- f is continuous at a: for every ε > 0 some δ is a good choice
def ContAt (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

end L110
