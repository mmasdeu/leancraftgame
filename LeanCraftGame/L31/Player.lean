/-
# Spot the bug: structures

*Sam rebuilt this world's structures for a project of their own: Gaussian integers as in
level 30, points with rational coordinates, a unit interval. Each piece compiles, and
each one is wrong. Noor wants a counterexample for each, so that Sam sees the bug rather
than being told about it.*

```lean
structure GaussInt where
  re : ℤ
  im : ℤ

-- the product (a + bi)(c + di)
def GaussInt.mul (z w : GaussInt) : GaussInt :=
  ⟨z.re * w.re + z.im * w.im, z.re * w.im + z.im * w.re⟩

structure Point where
  x : ℚ
  y : ℚ
  z : ℚ

-- the midpoint of a and b
def Point.mid (a b : Point) : Point :=
  ⟨(a.x + b.x) / 2, (a.y + b.y) / 2, (a.z + a.z) / 2⟩

-- the rational numbers t with 0 ≤ t ≤ 1
structure UnitInterval where
  t : ℚ
  in_range : 0 ≤ t ∨ t ≤ 1
```

## Reading a structure

* A wrong **operation** shows on a particular input: find one where it disagrees with
  the right formula. Beware of inputs that make the wrong term vanish.
* A **symmetric** notion (the midpoint of `a` and `b` is the midpoint of `b` and `a`)
  gives a test for free: swap the arguments and compare.
* A propositional field can be **vacuous**: so weak that junk satisfies it. Here, an
  element of `UnitInterval` is a number together with a proof of `in_range`. Find a
  number that satisfies Sam's `in_range` and is not in `[0, 1]`.

## Your task

Give the counterexamples. The template has Sam's types; the referee uses its own copy
of Sam's functions.
-/
import Mathlib.Tactic

namespace L31

structure GaussInt where
  re : ℤ
  im : ℤ

structure Point where
  x : ℚ
  y : ℚ
  z : ℚ

-- two Gaussian integers whose product Sam gets wrong
def gz : GaussInt := sorry
def gw : GaussInt := sorry

-- two points a, b with `mid a b ≠ mid b a`
def pa : Point := sorry
def pb : Point := sorry

-- a number that satisfies Sam's `in_range` but is not between 0 and 1
def badT : ℚ := sorry

end L31
