/-
# Vector spaces and linear maps

MIL's chapter on linear algebra starts with the hypotheses that make `V` a vector space
over a field `K`:

```lean
variable {K : Type*} [Field K] {V : Type*} [AddCommGroup V] [Module K V]
```

Read them as: `K` is a field, `V` has an addition with `0` and `-`, and `K` acts on `V`
by scalar multiplication `c • v` (type `\smul`), with the usual rules. Mathlib says
"module" for what a course says "vector space": over a field they are the same thing.
The plane `ℚ²` is the type `Fin 2 → ℚ`: a vector is a function from the two indices `0`,
`1` to `ℚ`, written `![x, y]`, and `v 0`, `v 1` are its coordinates.

## Linear maps are bundled

A linear map `V →ₗ[K] W` (type `\to\_l`) is a **structure**: a function together with
the proofs that it is linear.

```lean
structure LinearMap … (M : Type*) (M₂ : Type*) … where
  toFun : M → M₂
  map_add' : ∀ x y, toFun (x + y) = toFun x + toFun y
  map_smul' : ∀ (c : R) x, toFun (c • x) = c • toFun x
```

MIL builds one by giving the three fields:

```lean
example : V →ₗ[K] V where
  toFun v := 3 • v
  map_add' _ _ := smul_add ..
  map_smul' _ _ := smul_comm ..
```

A linear map is used like a function (`φ v`): Lean inserts a *coercion* from the structure
to its `toFun`. Its kernel and range are `LinearMap.ker φ` and `LinearMap.range φ`, which
are subspaces of `V` and `W` (next level).

Here you give the `toFun` only: the referee proves `map_add'` and `map_smul'` for you, or
finds that they fail.

## Not every formula is linear

`v ↦ v + ![1, 0]` moves every point one step to the right. It looks harmless, but it is
not linear: a linear map sends `0` to `0`, since `φ 0 = φ (0 + 0) = φ 0 + φ 0`.

## Your task

1. `rot`: the rotation of the plane by a quarter turn, counterclockwise: it sends
   `![1, 0]` to `![0, 1]` and `![0, 1]` to `![-1, 0]`.
2. `proj`: the projection onto the first coordinate axis: `![x, y] ↦ ![x, 0]`.
3. Refute the linearity of `shift`: give two vectors `u` and `w` such that
   `shift (u + w) ≠ shift u + shift w`.
-/
import Mathlib.LinearAlgebra.Matrix.ToLin

namespace L39

def rot : (Fin 2 → ℚ) → (Fin 2 → ℚ) := sorry

def proj : (Fin 2 → ℚ) → (Fin 2 → ℚ) := sorry

-- a translation, given
def shift : (Fin 2 → ℚ) → (Fin 2 → ℚ) := fun v => v + ![1, 0]

-- two vectors on which `shift` is not additive
def u : Fin 2 → ℚ := sorry
def w : Fin 2 → ℚ := sorry

end L39
