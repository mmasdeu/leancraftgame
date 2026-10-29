/-
# Spot the bug: the library

A colleague used Mathlib's notions, but not quite as Mathlib means them.

```lean
-- d is a common divisor of a and b
def CommonDivisor (d a b : ℕ) : Prop := a ∣ d ∧ b ∣ d

-- p and p + 2 are both prime (a twin prime)
def TwinPrime (p : ℕ) : Prop := Nat.Prime p ∨ Nat.Prime (p + 2)

-- the multiples of k: 0, k, 2k, 3k, …
def multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}
```

Library notions have fixed meanings and fixed argument orders, and a
definition that uses them can still say the wrong thing:

* `a ∣ b` reads "a divides b": the *small* number comes first.
* `∨` and `∧` matter as much as ever.
* In a set-builder `{n | …}`, check which variable is the element and which is
  the parameter.

## Your task

Each counterexample must be **accepted** by the colleague's definition,
although it does not have the property in the comment:

* `cdD`, `cdA`, `cdB`: `CommonDivisor cdD cdA cdB` holds, but `cdD` does not
  divide both `cdA` and `cdB`.
* `twin`: `TwinPrime twin` holds, but `twin` and `twin + 2` are not both prime.
* `mulK`, `mulN`: `mulN ∈ multiplesOf mulK` holds, but `mulN` is not a multiple
  of `mulK`.
-/
namespace L28

-- The colleague's code, to read (the referee uses its own copy).
def CommonDivisor (d a b : ℕ) : Prop := a ∣ d ∧ b ∣ d
def TwinPrime (p : ℕ) : Prop := Nat.Prime p ∨ Nat.Prime (p + 2)
def multiplesOf (k : ℕ) : Set ℕ := {n | k % n = 0}

-- accepted by CommonDivisor, but cdD is not a common divisor
def cdD : ℕ := sorry
def cdA : ℕ := sorry
def cdB : ℕ := sorry

-- accepted by TwinPrime, but not a twin prime
def twin : ℕ := sorry

-- mulN ∈ multiplesOf mulK, but mulN is not a multiple of mulK
def mulK : ℕ := sorry
def mulN : ℕ := sorry

end L28
