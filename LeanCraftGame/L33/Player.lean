/-
# Spot the bug: the library

Three definitions from a colleague who used Mathlib's notation without
checking which way round it goes.

* `a ∣ d ∧ b ∣ d` reads "`a` divides `d` and `b` divides `d`": a common
  **multiple**, not a common divisor. Which is too weak, which too strong?
* `Nat.Prime p ∨ Nat.Prime (p + 2)`: one prime suffices.
* `{n | k % n = 0}` is the set of **divisors** of `k`, not of its
  multiples. The two sets meet (both contain `k`, when `k > 0`), so the
  definition is right on some inputs: you need one where it is wrong.

For `∣`, the mnemonic: `a ∣ b` is "a divides b", the small number on the
left, like `a ≤ b` (for positive numbers).

## Your task

For each definition, give an input on which it is wrong. Small numbers help
the referee.
-/
namespace L33

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

end L33
