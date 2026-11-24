/-
# Continuity

Continuity of `f : ℝ → ℝ` at `a`, Weierstrass's way:

> for every `ε > 0` there is `δ > 0` such that `|x - a| < δ` implies
> `|f x - f a| < ε`.

It is clearer to split the definition in two, as you would in a proof:
first say what it means for a given `δ` to *work* for a given `ε`, then
quantify. Splitting a long definition into named pieces is good practice
in Lean as on paper: each piece can be tested on its own, and the pieces
are reused.

The step function (`0` for `x < 0`, `1` for `x ≥ 0`) is the test case: at
`a = 0`, for `ε = 1/2` no `δ` works, since points just left of `0` jump.
At every other point it is continuous.

In the Topology world the same notion will be defined with no `ε` at all:
inverse images of open sets are open. That the two agree for maps `ℝ → ℝ`
is a theorem, and the reason the topological definition is the right
generalisation.

## Your task

Define `IsDeltaFor f a ε δ` and then `ContAt f a` using it.
-/
namespace L40

-- f stays between -M and M (already done)
def BoundedBy (f : ℝ → ℝ) (M : ℝ) : Prop := ∀ x, |f x| ≤ M

-- δ is a good choice for ε at a: δ > 0, and every x within δ of a
-- has f x within ε of f a
def IsDeltaFor (f : ℝ → ℝ) (a ε δ : ℝ) : Prop := sorry

-- f is continuous at a: for every ε > 0 some δ is a good choice
def ContAt (f : ℝ → ℝ) (a : ℝ) : Prop := sorry

end L40
