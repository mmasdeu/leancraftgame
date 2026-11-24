/-
# Challenge: triangles

Three lengths `a, b, c` form a triangle when each is smaller than the sum of
the other two (strictly, if the triangle is not to be flat). All three
inequalities are needed: `1, 2, 10` satisfies two of them.

A right triangle has `a² + b² = c²`, *where `c` is the longest side*. If you
do not know which side is the hypotenuse, you must allow each of them. And a
side of length `0` is not a side: `0² + 5² = 5²` is not a triangle.

Parity puzzle: in a primitive Pythagorean triple exactly one of the two legs
is even, and the hypotenuse is odd. "Exactly one of three" is a statement
with several cases; spell them out.

## Your task

Define `IsTriangle`, `IsRight` and `ExactlyOneEven`. The referee checks them
on all small inputs against facts about triangles.
-/

namespace L10

-- a, b, c are the side lengths of a non-degenerate triangle (strict triangle inequalities)
def IsTriangle (a b c : Nat) : Prop := sorry

-- a, b, c are the sides of a right triangle, the hypotenuse being any of the three
def IsRight (a b c : Nat) : Prop := sorry

-- exactly one of a, b, c is even
def ExactlyOneEven (a b c : Nat) : Prop := sorry

end L10
