/-
# Vector spaces and linear maps

*A new project: linear algebra in the plane. The `Point` of level 28 had `add` and `smul`.
Now Mathlib supplies them, and Noor asks which maps respect them. Sam has already proposed
one that doesn't.*

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
it's linear.

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

You apply it like a function (`φ v`), through a coercion. Its kernel `LinearMap.ker φ` and
range `LinearMap.range φ` are subspaces (next level).

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

namespace L39

def rot : (Fin 2 → ℚ) → (Fin 2 → ℚ) := sorry

def proj : (Fin 2 → ℚ) → (Fin 2 → ℚ) := sorry

-- a translation, given
def shift : (Fin 2 → ℚ) → (Fin 2 → ℚ) := fun v => v + ![1, 0]

-- two vectors on which `shift` isn't additive
def u : Fin 2 → ℚ := sorry
def w : Fin 2 → ℚ := sorry

end L39
