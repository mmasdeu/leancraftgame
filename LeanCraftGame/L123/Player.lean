/-
# Functions on structures

A structure is a type like any other, so a function can take structures as
inputs and give a structure as its output.

```lean
structure Point where
  x : ℕ
  y : ℕ

def Point.add (p q : Point) : Point :=
  ⟨p.x + q.x, p.y + q.y⟩
```

* `(p q : Point)` declares two inputs of the same type `Point`.
* The output is a new `Point`, built with `⟨ , ⟩`: first the new `x`, then the
  new `y`. The fields of the inputs are read with `p.x`, `q.y`, …
* The function is called `Point.add`, **inside the name `Point`**. This is not
  just a habit: it enables *dot notation*. For a point `p` and a point `q`,
  `p.add q` means `Point.add p q`.

## Grouping with `namespace`

Instead of writing `Point.` in front of every name, open a `namespace`:

```lean
namespace Point

def add (p q : Point) : Point := ⟨p.x + q.x, p.y + q.y⟩

def double (p : Point) : Point := p.add p

end Point
```

Inside the namespace, `add` and `double` are really called `Point.add` and
`Point.double`, and `double` can use `add` by its short name.

## Pattern matching on a structure

Instead of reading the fields with `p.x`, a function may *take the structure
apart* in its patterns, as `Recursion` did with numbers:

```lean
def Point.add : Point → Point → Point
  | ⟨a, b⟩, ⟨c, d⟩ => ⟨a + c, b + d⟩
```

The pattern `⟨a, b⟩` matches a point and names its two fields `a` and `b`.
Two inputs, two patterns, separated by a comma. Both styles are equally good.

## Take care

* The fields of the *output* `⟨_, _⟩` must come in the declared order.
* Natural numbers still stop at zero: `3 - 5` is `0`.

## Your task

`Point` and `Rectangle` are declared for you (a `Rectangle` has a `width` and
a `height`; it sits with one corner at the point `⟨0, 0⟩`). Fill in the five
functions. The comments give examples.
-/
namespace L123

structure Point where
  x : ℕ
  y : ℕ

structure Rectangle where
  width : ℕ
  height : ℕ

namespace Point

-- add the two coordinates separately    (add ⟨1, 2⟩ ⟨3, 4⟩ is ⟨4, 6⟩)
def add (p q : Point) : Point := sorry

-- the squared distance between two points: (difference of the x's)² plus
-- (difference of the y's)², where a difference is never negative
--   (dist2 ⟨0, 0⟩ ⟨3, 4⟩ is 25, and so is dist2 ⟨3, 4⟩ ⟨0, 0⟩)
def dist2 (p q : Point) : ℕ := sorry

end Point

namespace Rectangle

-- width times height
def area (r : Rectangle) : ℕ := sorry

-- the rectangle with a margin of `k` added on every side: both the width and
-- the height grow by 2 * k     (grow ⟨7, 2⟩ 1 is ⟨9, 4⟩)
def grow (r : Rectangle) (k : ℕ) : Rectangle := sorry

-- the corner opposite to the origin, as a point    (topRight ⟨7, 2⟩ is ⟨7, 2⟩)
def topRight (r : Rectangle) : Point := sorry

end Rectangle

end L123
