/-
# Divisibility and gcd

Time to define real number theory. Everything is built from `a ∣ b` ("`a`
divides `b`", typed `\|`), quantifiers and the Mathlib notions you already know.

Two things to keep in mind about `∣` on `ℕ`:

* `1 ∣ n` and `n ∣ n` always hold, and `n ∣ 0` for **every** `n` (including
  `0 ∣ 0`);
* `0 ∣ n` holds only for `n = 0`.

So a statement like "`∀ e, e ∣ a → e ∣ b → …`" quantifies over *all* common
divisors, and for `a = b = 0` every number is one.

A **greatest common divisor** of `a` and `b` can be described in two ways. The
algebraist's way: `d` is a common divisor, and **every** common divisor
divides `d`. The schoolbook way: `d` is a common divisor and it is the
largest one. On `ℕ` they usually agree, but not always: check the corner cases
before you trust a definition.

```lean
-- d divides both a and b (already done, from "Using Mathlib")
def CommonDiv (d a b : ℕ) : Prop := d ∣ a ∧ d ∣ b
```

## Your task

`CommonDiv` is done. Define `Coprime'` (no common divisor except 1), `IsGcd`
(`d` is *the* greatest common divisor, in the algebraist's way), `IsPrime'`
(a prime is a number greater than 1 whose only divisors are 1 and itself)
and `Squarefree'` (no square `d * d` other than `1` divides `n`). Do not use
Mathlib's `Nat.gcd`, `Nat.Coprime`, `Nat.Prime` or `Squarefree`: the referee
compares your definitions to them.
-/
namespace L108

-- d divides both a and b (already done)
def CommonDiv (d a b : ℕ) : Prop := d ∣ a ∧ d ∣ b

-- a and b have no common divisor other than 1       (Coprime' 8 15 is true)
def Coprime' (a b : ℕ) : Prop := sorry

-- d is a greatest common divisor of a and b: a common divisor that every
-- common divisor divides                            (IsGcd 12 18 6 is true)
def IsGcd (a b d : ℕ) : Prop := sorry

-- p is a prime number
def IsPrime' (p : ℕ) : Prop := sorry

-- no square d * d with d ≠ 1 divides n               (Squarefree' 6 is true)
def Squarefree' (n : ℕ) : Prop := sorry

end L108
