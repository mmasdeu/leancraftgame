/-
# Recursion and induction

*In level 18 you read `sbAux`, a definition by recursion. Now Noor wants the Annex's own:
factorials, Fibonacci numbers and sums, plus a fact about them for the Prover. You only
state the fact; the Prover proves it by induction.*

## Pattern matching

```lean
def pow2 : ℕ → ℕ
  | 0 => 1
  | n + 1 => 2 * pow2 n
```

No `:=`. Each line `| pattern => value` covers one shape of the argument. A natural number
is `0` or `n + 1`, so two lines cover everything, and `pow2 (n + 1)` may call `pow2 n`.
The `0` line is where every value starts: `pow2 3 = 2 * (2 * (2 * 1))`. Patterns can go
deeper:

```lean
def blink : ℕ → ℕ      -- 0, 1, 0, 1, …
  | 0 => 0
  | 1 => 1
  | n + 2 => blink n
```

## The Collatz map

One Collatz step halves an even number and sends an odd `n` to `3 n + 1`. The conjecture
says repeating it from any `n ≥ 1` reaches `1`. Nobody knows. For a step that depends on
`n`, use `if c then a else b` (as in `late`, level 12): it is `a` when `c` holds and `b`
otherwise.

## Your task

Fill in:

* `fac`: the factorial, `fac n = 1 · 2 ⋯ n`.
* `fib`: the Fibonacci numbers, `fib 0 = 0`, `fib 1 = 1`, and each next one the sum of the
  two before.
* `sumTo n = 0 + 1 + ⋯ + n`.
* `collatz`: one Collatz step.

Then state (don't prove) `fac_ge`: for all `n`, `2 ^ (n - 1) ≤ n !`. Mathlib's factorial
is `Nat.factorial n`, also written `n !`. State it with `Nat.factorial`, not with your
`fac`.
-/
namespace L22

def fac : ℕ → ℕ
  | 0 => sorry
  | n + 1 => sorry

def fib : ℕ → ℕ
  | 0 => sorry
  | 1 => sorry
  | n + 2 => sorry

-- 0 + 1 + 2 + ⋯ + n, by recursion
def sumTo : ℕ → ℕ
  | 0 => sorry
  | n + 1 => sorry

-- one step of the Collatz map
def collatz (n : ℕ) : ℕ := sorry

statement fac_ge : sorry

end L22
