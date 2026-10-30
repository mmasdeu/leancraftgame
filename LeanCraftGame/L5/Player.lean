/-
# Spot the bug

Until now you have *written* definitions. Every world from here on ends with a
level where you **read** someone else's definitions instead, and prove them
wrong. This is the everyday skill of checking a formalisation: an AI or a
colleague hands you code that compiles, and you must find out whether it means
what it claims.

How do you prove that a definition is wrong? Not by saying so: by giving a
**counterexample**, an input on which it gives the wrong answer. The referee
then checks your counterexample against the right answer, so it is evidence,
not opinion.

A colleague wrote the two functions below. Both compile, both look reasonable,
and both are wrong.

```lean
-- the middle one of three numbers (the median): middle 1 5 3 is 3
def middle (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else c)
  else (if a ≤ c then a else c)

-- is year y a leap year? A year divisible by 4 is a leap year, except the
-- centuries, except every fourth century: 2024 and 2000 were leap years,
-- 2023 and 1900 were not.
def isLeap (y : Nat) : Bool := y % 4 == 0 && y % 100 != 0
```

(`==` and `!=` compare two numbers and give a `Bool`; `&&` is "and" for
`Bool`s.)

## How to hunt

* **Run the code in your head on small inputs.** Try the cases the author was
  probably thinking of, then the ones they probably were not.
* **Walk through every branch of an `if`.** Each branch is a claim. Find inputs
  that land in each branch, and check the claim there.
* **Read the specification again, word by word.** Every "except" is a case
  someone may have forgotten.

## Your task

Give three numbers on which `middle` returns the wrong number, and a year on
which `isLeap` gives the wrong answer.
-/
namespace L5

-- The colleague's code, to read (changing it here changes nothing: the
-- referee uses its own copy).
def middle (a b c : Nat) : Nat :=
  if a ≤ b then (if b ≤ c then b else c)
  else (if a ≤ c then a else c)

def isLeap (y : Nat) : Bool := y % 4 == 0 && y % 100 != 0

-- Three numbers on which `middle` is wrong.
def ma : Nat := sorry
def mb : Nat := sorry
def mc : Nat := sorry

-- A year on which `isLeap` is wrong.
def year : Nat := sorry

end L5
