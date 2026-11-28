/-
# Vector spaces and linear maps

*A new project: linear algebra in the plane. The `Point` you wrote in level 28 had `add`
and `smul`. Now Mathlib supplies them, and Noor asks which maps respect them. Sam has
already proposed one that doesn't.*

Linear algebra in Mathlib starts with these hypotheses:

```lean
variable {K : Type*} [Field K] {V : Type*} [AddCommGroup V] [Module K V]
```

`K` is a field, `V` has an addition with `0` and `-`, and `K` acts on `V` by scalar
multiplication `c • v` (type `\smul`). Mathlib says "module" for "vector space". Over a
field they're the same. The plane `ℚ²` is the type `Fin 2 → ℚ`. A vector `![x, y]` is a
function from the indices `0`, `1` to `ℚ`, and `v 0`, `v 1` are its coordinates.

## Linear maps are bundled

A linear map `V →ₗ[K] W` (type `\to\_l`) is a **structure**: a function plus proofs that
it's linear. Roughly:

```lean
structure LinearMap (V W : Type*) where
  toFun : V → W
  map_add' : ∀ x y, toFun (x + y) = toFun x + toFun y
  map_smul' : ∀ (c : K) x, toFun (c • x) = c • toFun x
```

You apply it like a function, `φ v`.

Here you give only the `toFun`. The referee proves `map_add'` and `map_smul'`, or finds
that they fail.

## Not every formula is linear

Sam's `shift`, `v ↦ v + ![1, 0]`, moves every point one step right. It isn't linear. A
linear map sends `0` to `0`, since `φ 0 = φ (0 + 0) = φ 0 + φ 0`.

The quarter turn is linear. It's multiplication by `i` on the Gaussian integers of
level 30, read in coordinates.

## Your task

1. `rot`: the counterclockwise quarter turn. It sends `![1, 0]` to `![0, 1]` and
   `![0, 1]` to `![-1, 0]`.
2. `proj`: the projection onto the first axis, `![x, y] ↦ ![x, 0]`.
3. Show `shift` isn't linear: give two vectors `u` and `w` with
   `shift (u + w) ≠ shift u + shift w`.
-/
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace L35

def rot : (Fin 2 → ℚ) → (Fin 2 → ℚ) := sorry

def proj : (Fin 2 → ℚ) → (Fin 2 → ℚ) := sorry

-- a translation, given
def shift : (Fin 2 → ℚ) → (Fin 2 → ℚ) := fun v => v + ![1, 0]

-- two vectors on which `shift` isn't additive
def u : Fin 2 → ℚ := sorry
def w : Fin 2 → ℚ := sorry

end L35
