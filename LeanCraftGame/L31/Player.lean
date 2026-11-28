/-
# Spot the bug: structures

*Sam rebuilt this world's structures for a side project. Each piece compiles and each is
wrong. Noor wants a counterexample for each, so Sam can see the bug.*

Sam's code is at the top of the editor. Don't edit it: the referee tests your
counterexamples against its own copy.

## Reading a structure

* A wrong operation shows up on some input where it disagrees with the right formula.
  Avoid inputs where the wrong term is zero.
* A symmetric notion gives a free test. The midpoint of `a` and `b` is the midpoint of `b`
  and `a`, so swap the arguments and compare.
* A propositional field can be **vacuous**, so weak that junk satisfies it. Read its
  connectives (`∧`, `∨`, level 11) closely.

## Your task

Give the counterexamples asked for below Sam's code.
-/
import Mathlib.Tactic

namespace L31

-- Sam's code (don't edit)
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

-- Your counterexamples
-- two Gaussian integers whose product Sam gets wrong
def gz : GaussInt := sorry
def gw : GaussInt := sorry

-- two points a, b with `mid a b ≠ mid b a`
def pa : Point := sorry
def pb : Point := sorry

-- a number that satisfies Sam's `in_range` but isn't between 0 and 1
def badT : ℚ := sorry

end L31
