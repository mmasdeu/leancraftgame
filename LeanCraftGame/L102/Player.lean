/-
# Challenge: calendars and triangles

Three definitions from everyday life, each with a trap or two. Combine what
you know: `∧`, `∨`, `¬`, `=`, `≠`, `<`, `≤`, `%`, and parentheses wherever
you are unsure (remember: `∧` binds tighter than `∨`).

* **Leap years** (Gregorian calendar): a year is a leap year if it is
  divisible by 4, *except* that years divisible by 100 are not, *except*
  that years divisible by 400 are. So 2024 and 2000 are leap years; 1900
  and 2023 are not.
* **Triangles**: three lengths `a b c` (natural numbers) are the sides of a
  triangle when each side is **strictly** shorter than the other two put
  together. A "flat triangle" with sides 1, 2, 3 does not count. Do not use
  subtraction.
* **Exactly one even**: of the three numbers `a b c`, exactly one is even.
  (Not "at least one", and not "all of them".)

The tests are hidden: think about the edge cases before you run.
-/
namespace L102

-- the Gregorian rule                (LeapYear 2024 is true, LeapYear 1900 is false)
def LeapYear (y : Nat) : Prop := sorry

-- a, b, c are the sides of a (non-flat) triangle      (IsTriangle 3 4 5 is true)
def IsTriangle (a b c : Nat) : Prop := sorry

-- exactly one of a, b, c is even       (ExactlyOneEven 2 3 5 is true, ExactlyOneEven 2 4 5 is false)
def ExactlyOneEven (a b c : Nat) : Prop := sorry

end L102
