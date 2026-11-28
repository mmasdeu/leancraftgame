/-
# Defining structures

*Noor starts a new project: the library needs objects of its own, beginning with a point of
space. Your `Point` comes back later as a class instance and as a vector.*

A **structure** bundles data together:

```lean
structure Point where
  x : ℝ
  y : ℝ
  z : ℝ
```

A `Point` has three fields. You can build one in three ways:

```lean
def p : Point := ⟨1, 2, 3⟩                    -- anonymous constructor: fields in order
def q : Point := Point.mk 1 2 3               -- `Point.mk` builds a Point from its fields
def r : Point := { x := 1, y := 2, z := 3 }   -- field names: order does not matter
```

`p.x` is the first coordinate of `p`.

## Dot notation

A function in the namespace `Point` can be called with a dot:

```lean
def Point.neg (a : Point) : Point := ⟨-a.x, -a.y, -a.z⟩
-- now `p.neg` means `Point.neg p`
```

## Fields that are propositions

A field can also be a property. The standard 2-simplex is the triangle of points with
nonnegative coordinates that add up to 1:

```lean
structure StandardTwoSimplex where
  x : ℝ
  y : ℝ
  z : ℝ
  x_nonneg : 0 ≤ x
  -- … one field for each remaining property
```

An element needs the numbers and proofs of the properties. The referee tests your fields
on points inside and outside the simplex. Leave out one property and an unwanted point
gets in.

## Your task

Write the definitions, and finish `StandardTwoSimplex`: after the three coordinates, add
the fields `x_nonneg`, `y_nonneg`, `z_nonneg` and `sum_eq`, in this order.
-/
import Mathlib.Tactic

namespace L27

-- points of space (already done)
structure Point where
  x : ℝ
  y : ℝ
  z : ℝ

-- the origin, written with field names `{ x := …, y := …, z := … }`
def origin : Point := sorry

-- the point (1, 2, 3), written with `⟨…⟩`
def p123 : Point := sorry

-- the sum of two points, coordinate by coordinate
def Point.add (a b : Point) : Point := sorry

-- the point a scaled by the factor r
def Point.smul (r : ℝ) (a : Point) : Point := sorry

-- the points with nonnegative coordinates whose sum is 1
structure StandardTwoSimplex where
  x : ℝ
  y : ℝ
  z : ℝ
  -- your four fields here

end L27
