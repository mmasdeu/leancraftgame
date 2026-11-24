/-
# Declaring a structure

A complex number is a pair of reals, a rational is a pair of integers, a
point of the plane is a pair of coordinates. Mathematics bundles data
constantly, and Lean does it with **structures**:

```lean
structure Point where
  x : ℤ
  y : ℤ
```

This declares a new type `Point` whose values have two **fields**. A value
is built with the constructor, `Point.mk 3 4`, or with the anonymous
constructor `⟨3, 4⟩` when the type is known. The fields are read with a dot:
`p.x`, `p.y`. The order of the fields is the order of the arguments.

The **Gaussian integers** `ℤ[i] = {a + b·i | a, b ∈ ℤ}` are the integer
points of the complex plane. They have a norm `N(a + bi) = a² + b²`, which is
multiplicative, and this is why a product of sums of two squares is a sum of
two squares (we will use that in the next level). A prime `p` is a sum of
two squares exactly when it splits in `ℤ[i]`: `5 = (2 + i)(2 - i)`.

The same data, a pair of integers, can mean a point or a Gaussian integer:
the type records the intended meaning, and `toPoint` translates.

## Your task

Declare the fields of `GaussInt`, then define the values and functions.
-/

namespace L44

-- a point of the plane with integer coordinates (already done)
structure Point where
  x : ℤ
  y : ℤ

-- a Gaussian integer a + b·i: two integer fields `re` and `im`, in this order
structure GaussInt where
  -- your fields here

-- the imaginary unit i = 0 + 1·i
def I : GaussInt := sorry

-- 3 + 4i
def z34 : GaussInt := sorry

-- the norm a² + b² of a + b·i
def normSq (z : GaussInt) : ℤ := sorry

-- the conjugate a - b·i of a + b·i
def conjugate (z : GaussInt) : GaussInt := sorry

-- the point (a, b) of the plane
def toPoint (z : GaussInt) : Point := sorry

end L44
