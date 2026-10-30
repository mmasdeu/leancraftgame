/-
# Declaring a structure

Sometimes one number is not enough to describe a thing. A point in the plane
needs *two* numbers. A **structure** bundles several values into one new type.

```lean
structure Point where
  x : ℕ
  y : ℕ
```

(`ℕ` is typed `\N`; it is the same type as `Nat`.) Read it piece by piece:

* `structure Point where` starts the definition of a new type called `Point`.
* Each following indented line is a **field**: a name, a colon, and the type of
  that field. Here `Point` has two fields, `x` and `y`, both natural numbers.
* The *order* of the fields matters, as you will see in a moment.

## Building a value

There are three ways to write down a point with `x = 3` and `y = 4`:

```lean
def p1 : Point := Point.mk 3 4
def p2 : Point := ⟨3, 4⟩
def p3 : Point := { x := 3, y := 4 }
```

* `Point.mk` is the **constructor**: a function that takes the fields in the
  order they were declared. `Point.mk 3 4` has `x = 3` and `y = 4`;
  `Point.mk 4 3` is a different point.
* `⟨3, 4⟩` (type `\<` and `\>`) is the same thing, shorter: Lean knows from
  the type `Point` after the colon what the brackets build.
* `{ x := 3, y := 4 }` names every field, so the order does not matter, and
  nobody can mix the fields up.

## Reading a field

Write the value, a dot, and the name of the field:

```lean
p1.x      -- is 3
p1.y      -- is 4
Point.x p1  -- the same as p1.x
```

Every field is a function: `Point.x : Point → ℕ`. And `(Point.mk 3 4).y` is 4.

## Your task

`Point` is declared for you. Declare a `Rectangle` with a `width` and then a
`height`, and a `Card` with a `rank` and then a `suit`, all natural numbers
(the suit is a number: 0 clubs, 1 diamonds, 2 hearts, 3 spades). Then build
the values described in the comments, and read fields to write the two
functions at the end.
-/
namespace L122

structure Point where
  x : ℕ
  y : ℕ

-- fields `width` and `height`, in this order, natural numbers
structure Rectangle where
  -- your fields here

-- fields `rank` and `suit`, in this order, natural numbers
structure Card where
  -- your fields here

-- the point with x = 0 and y = 0
def origin : Point := sorry

-- the point with x = 3 and y = 4
def p34 : Point := sorry

-- the rectangle with width 7 and height 2
def wide : Rectangle := sorry

-- the queen (rank 12) of hearts (suit 2)
def queenOfHearts : Card := sorry

-- the perimeter of a rectangle: twice (width + height)
def perimeter (r : Rectangle) : ℕ := sorry

-- the point with its two coordinates exchanged    (swapPoint ⟨3, 4⟩ is ⟨4, 3⟩)
def swapPoint (p : Point) : Point := sorry

end L122
