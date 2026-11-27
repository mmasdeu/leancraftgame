/-
# Defining structures

*Noor starts a new project: the library needs objects of its own, and the first is a point
of space. The `Point` you write today comes back later as a class instance and as a vector.*

A **structure** bundles data together. A point of space:

```lean
@[ext]
structure Point where
  x : ℝ
  y : ℝ
  z : ℝ
```

A `Point` has three fields. You can build one in three ways:

```lean
def p : Point := ⟨1, 2, 3⟩                    -- anonymous constructor: fields in order
def q : Point := Point.mk 1 2 3               -- the constructor `Point.mk`
def r : Point := { x := 1, y := 2, z := 3 }   -- field names: order does not matter
```

`p.x` is the first coordinate of `p`. `@[ext]` gives you the lemma "two points are equal
when their coordinates are equal".

## Dot notation

You can call a function in the namespace `Point` with a dot:

```lean
def Point.neg (a : Point) : Point := ⟨-a.x, -a.y, -a.z⟩
-- now `p.neg` means `Point.neg p`
```

## Fields that are propositions

A field can also be a property. The standard 2-simplex is the set of points with
nonnegative coordinates that add up to 1:

```lean
structure StandardTwoSimplex where
  x : ℝ
  y : ℝ
  z : ℝ
  x_nonneg : 0 ≤ x
  …
```

To build an element, you give the numbers and proofs of the properties. The referee tests
your fields on points that should and shouldn't be in the simplex. Leave out one property
and a point Noor never wanted gets in.

## Your task

Write the definitions, and finish `StandardTwoSimplex`: after the three coordinates, add
the fields `x_nonneg`, `y_nonneg`, `z_nonneg` and `sum_eq`, in this order.
-/
import Mathlib.Tactic

namespace L28

-- points of space (already done)
@[ext]
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

end L28
