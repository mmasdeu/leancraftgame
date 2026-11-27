/-
# Derivatives in normed spaces

*Noor's next request is derivatives of maps between planes, such as the quarter-turn
`rot` of level 39, now on `ℝ × ℝ`: `(x, y) ↦ (-y, x)`. The derivative of such a map is
not a number any more, and the objects of the Linear Algebra world come back: it is a
linear map.*

Mathlib differentiates functions between **normed spaces**: `f : E → F`, where `E` and
`F` have a norm `‖x‖` and are vector spaces over `ℝ`. The plane `ℝ × ℝ` is one, and so is
`ℝ` itself. The derivative of `f` at a point is the **best linear approximation** of `f`
near that point. For a map that is already linear, like `rot`, it is the map itself, at
every point (`ContinuousLinearMap.fderiv`).

```lean
variable {E F : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
  [NormedAddCommGroup F] [NormedSpace ℝ F]

#check fderiv ℝ f x        -- fderiv ℝ f x : E →L[ℝ] F
#check HasFDerivAt f f' x  -- f' : E →L[ℝ] F
#check ContDiff ℝ n f      -- f is n times continuously differentiable
```

* `E →L[ℝ] F` is the type of **continuous linear maps** from `E` to `F`. It is a
  structure, but it can be applied like a function: `fderiv ℝ f x v` is the derivative of
  `f` at `x` in the direction `v`.
* The `F` in `fderiv` stands for *Fréchet*. Its arguments `𝕜` (here `ℝ`), `f` and `x` are
  explicit; `E` and `F` are implicit, found from the type of `f`.
* For `f : ℝ → ℝ`, `deriv f x` is defined as `fderiv ℝ f x 1`: the linear map applied to
  the direction `1`.
* `ContDiff ℝ 1 f` says that `f` is differentiable and its derivative is continuous;
  `ContDiff ℝ 2 f` asks the same of the derivative, and so on.

## Which norm?

On `ℝ × ℝ`, Mathlib's norm is the **maximum** of the absolute values of the coordinates,
`‖(x, y)‖ = max |x| |y|`, not the Euclidean length `√(x² + y²)`. (The Euclidean plane is a
different type, `EuclideanSpace ℝ (Fin 2)`.) The derivative does not depend on the choice,
since all norms on a finite-dimensional space are equivalent, but a statement that
mentions `‖·‖` does: Sam's first `normPair` was `5`.

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
