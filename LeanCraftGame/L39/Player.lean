/-
# Vector spaces and linear maps

*A new project: linear algebra, starting in the plane. You've met vectors already: the
`Point` of level 28 had `add` and `smul`. Now Mathlib supplies them, and Noor asks which
maps respect them. Sam has already proposed one that doesn't.*

Linear algebra in Mathlib starts with the hypotheses that make `V` a vector space over a
field `K`:

```lean
variable {K : Type*} [Field K] {V : Type*} [AddCommGroup V] [Module K V]
```

Read them as: `K` is a field, `V` has an addition with `0` and `-`, and `K` acts on `V` by
scalar multiplication `c • v` (type `\smul`) with the usual rules. Mathlib says "module"
where a course says "vector space". Over a field they're the same. The plane `ℚ²` is the
type `Fin 2 → ℚ`. A vector is a function from the indices `0`, `1` to `ℚ`, written
`![x, y]`, and `v 0`, `v 1` are its coordinates.

## Linear maps are bundled

A linear map `V →ₗ[K] W` (type `\to\_l`) is a **structure**: a function plus the proofs
that it's linear.

```lean
structure LinearMap … (M : Type*) (M₂ : Type*) … where
  toFun : M → M₂
  map_add' : ∀ x y, toFun (x + y) = toFun x + toFun y
  map_smul' : ∀ (c : R) x, toFun (c • x) = c • toFun x
```

You build one by giving the three fields:

```lean
example : V →ₗ[K] V where
  toFun v := 3 • v
  map_add' _ _ := smul_add ..
  map_smul' _ _ := smul_comm ..
```

You use a linear map like a function (`φ v`). Lean inserts a coercion from the structure
to its `toFun`. Its kernel and range, `LinearMap.ker φ` and `LinearMap.range φ`, are
subspaces of `V` and `W` (next level).

Here you give only the `toFun`. The referee proves `map_add'` and `map_smul'` for you, or
finds that they fail.

## Not every formula is linear

Sam's `shift`, `v ↦ v + ![1, 0]`, moves every point one step right. It looks harmless, but
it isn't linear. A linear map sends `0` to `0`, since `φ 0 = φ (0 + 0) = φ 0 + φ 0`.

The quarter turn is linear, and you've computed it before. It's multiplication by `i` on
the Gaussian integers of level 30, read in coordinates.

## Your task

1. `rot`: the counterclockwise quarter turn of the plane. It sends `![1, 0]` to `![0, 1]`
   and `![0, 1]` to `![-1, 0]`.
2. `proj`: the projection onto the first axis, `![x, y] ↦ ![x, 0]`.
3. Show `shift` isn't linear: give two vectors `u` and `w` with
   `shift (u + w) ≠ shift u + shift w`.
-/
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace L39

def rot : (Fin 2 → ℚ) → (Fin 2 → ℚ) := sorry

def proj : (Fin 2 → ℚ) → (Fin 2 → ℚ) := sorry

-- a translation, given
def shift : (Fin 2 → ℚ) → (Fin 2 → ℚ) := fun v => v + ![1, 0]

-- two vectors on which `shift` isn't additive
def u : Fin 2 → ℚ := sorry
def w : Fin 2 → ℚ := sorry

end L39
