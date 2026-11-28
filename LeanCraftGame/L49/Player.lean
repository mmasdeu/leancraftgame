/-
# Derivatives in normed spaces

*Noor now wants derivatives of maps between planes, like the quarter-turn `rot` of
level 39, now on the real plane `ℝ × ℝ`: `(x, y) ↦ (-y, x)`. The derivative of such a map
isn't a number. It's a linear map.*

Mathlib differentiates functions `f : E → F` between **normed spaces**: vector spaces over
`ℝ` with a norm `‖x‖` (read-only here; `\norm` in VS Code), such as `ℝ × ℝ` and `ℝ`. The
derivative of `f` at a point is the best linear approximation of `f` there. For a linear
map like `rot`, it's the map itself, at every point.

```lean
variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
  [NormedAddCommGroup F] [NormedSpace ℝ F]

#check fderiv ℝ f x        -- fderiv ℝ f x : E →L[ℝ] F
#check HasFDerivAt f f' x  -- f' : E →L[ℝ] F
```

* `E →L[ℝ] F` is the type of continuous linear maps from `E` to `F`. `×` binds tighter
  than `→L[ℝ]`, so `ℝ →L[ℝ] ℝ × ℝ` has target `ℝ × ℝ`.
* You can apply one like a function: `fderiv ℝ f x v` is the derivative of `f` at `x` in
  the direction `v`. For `rot`, `fderiv ℝ rot p (1, 0)` is `rot (1, 0) = (0, 1)`.

## Which norm?

On `ℝ × ℝ`, Mathlib's norm is the **maximum** of the absolute values of the coordinates,
`‖(x, y)‖ = max |x| |y|`, not the Euclidean length `√(x² + y²)`. (The Euclidean plane is
`EuclideanSpace ℝ (Fin 2)`.) All norms on a finite-dimensional space are equivalent, so
the derivative doesn't care. A statement that mentions `‖·‖` does. Sam's first `normPair`
was `5`.

## Your task

1. Replace the first `sorry` of `Df` by its **type**, and the second by its value,
   `fderiv ℝ f p`. Do the same for `Dg`.
2. `normPair`: the value of `‖((3 : ℝ), (-4 : ℝ))‖` in Mathlib, as a number.
3. Answer the questions below the lesson.
-/
import Mathlib.Analysis.Calculus.FDeriv.Basic
import Mathlib.Analysis.Calculus.FDeriv.Prod
import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.ContDiff.Defs

namespace L49

-- the derivative of a function from the plane to ℝ, at a point p
def Df (f : ℝ × ℝ → ℝ) (p : ℝ × ℝ) : sorry := sorry

-- the derivative of a curve in the plane, at a time t
def Dg (g : ℝ → ℝ × ℝ) (t : ℝ) : sorry := sorry

-- the value of ‖((3 : ℝ), (-4 : ℝ))‖, as a number
def normPair : ℝ := sorry

def q1 : Fin 4 := sorry
def q2 : Fin 4 := sorry
def q3 : Bool := sorry

end L49
