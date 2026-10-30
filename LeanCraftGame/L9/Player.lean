/-
# Spot the bug: connectives

A colleague defined three predicates. Each comes with a comment saying what
it should mean, and each says something else.

```lean
-- n is a teenager: from 13 to 19
def IsTeen (n : Nat) : Prop := 13 ≤ n ∨ n ≤ 19

-- day d is a weekend day (days are numbered 1 to 7, Saturday is 6, Sunday is 7)
def IsWeekend (d : Nat) : Prop := d = 6 ∧ d = 7

-- a and b are both odd
def BothOdd (a b : Nat) : Prop := ¬ a % 2 = 0 ∧ b % 2 = 0
```

A wrong predicate can be wrong in two directions:

* it **accepts** something it should reject (it is *too weak*), or
* it **rejects** something it should accept (it is *too strong*).

To prove the first, give an input that the predicate accepts, and show that it
should not. For the second, give an input that it rejects, and show that it
should accept it. The tests below say which direction each bug goes; your job
is to find the input.

Remember the binding strengths from "Or and not": `¬` binds tighter than `∧`,
which binds tighter than `∨`.

## Your task

* `teen`: a number that `IsTeen` accepts, although it is not from 13 to 19.
* `weekendDay`: a weekend day (6 or 7) that `IsWeekend` rejects.
* `oddA` and `oddB`: two numbers that `BothOdd` accepts, although they are not
  both odd.
-/
namespace L9

-- The colleague's code, to read (the referee uses its own copy).
def IsTeen (n : Nat) : Prop := 13 ≤ n ∨ n ≤ 19
def IsWeekend (d : Nat) : Prop := d = 6 ∧ d = 7
def BothOdd (a b : Nat) : Prop := ¬ a % 2 = 0 ∧ b % 2 = 0

-- accepted by IsTeen, but not a teenager
def teen : Nat := sorry

-- a weekend day, but rejected by IsWeekend
def weekendDay : Nat := sorry

-- accepted by BothOdd, but not both odd
def oddA : Nat := sorry
def oddB : Nat := sorry

end L9
