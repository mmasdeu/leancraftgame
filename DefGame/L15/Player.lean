/-
# Recursion

A function on natural numbers can be defined **by cases**, one line per shape
of the input:

```lean
def isZero : Nat → Bool
  | 0 => true
  | _ => false
```

* The input is not named before the colon. Instead, its type is part of the
  function type `Nat → Bool` ("from `Nat` to `Bool`"; type `→` as `\to`).
* Each line `| pattern => result` handles the inputs that match the pattern.
  `_` matches anything.

## Recursion

A case may use the function itself on a **smaller** input:

```lean
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n
```

* The pattern `n + 1` matches every number except 0, and names its
  predecessor `n`. So `factorial 4` is `4 * factorial 3`, and so on down to
  `factorial 0`.
* You cannot write the pattern `n - 1`: Lean matches on how a number is
  *built* (0, or one more than something), not on arbitrary formulas.
* Lean accepts the definition because each recursive call is on a smaller
  input, so the computation ends. If it cannot see that, it reports an error
  about *termination*.
* You may also write `match n with` followed by the same `|` lines, inside a
  definition with a named input `(n : Nat)`.

## Your task

`factorial` is done. Fill in the right-hand sides of the cases below.
-/
namespace L15

-- 1 * 2 * … * n (already done)
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n

-- 0 + 1 + 2 + … + n          (sumTo 4 is 10)
def sumTo : Nat → Nat
  | 0 => sorry
  | n + 1 => sorry

-- 2 multiplied by itself n times   (pow2 3 is 8, pow2 0 is 1)
def pow2 : Nat → Nat
  | 0 => sorry
  | n + 1 => sorry

-- the Fibonacci numbers 0, 1, 1, 2, 3, 5, 8, …: each one is the sum of the two before it
def fib : Nat → Nat
  | 0 => sorry
  | 1 => sorry
  | n + 2 => sorry

end L15
