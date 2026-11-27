/-
# Recursion and induction

*In level 18 you read `sbAux`, a definition by recursion. Now Noor wants the Annex's own:
factorials, Fibonacci numbers and sums, plus a few facts about them for the Prover. You
only state the facts; they're proved by induction.*

## Pattern matching

```lean
def fac : ℕ → ℕ
  | 0 => 1
  | n + 1 => (n + 1) * fac n
```

No `:=`. Each line `| pattern => value` covers one shape of the argument. A natural number
is `0` or `n + 1`, so two lines cover everything, and `fac (n + 1)` may call `fac n`.
Every value is built from the `0` line, so get it right. Patterns can go deeper:

```lean
def fib : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | n + 2 => fib n + fib (n + 1)
```

## Sums: `∑ i ∈ Finset.range n, f i`

`Finset.range n` is `{0, 1, …, n - 1}`. It has `n` elements and does **not** contain `n`.
So `∑ i ∈ Finset.range n, i` is `0 + 1 + ⋯ + (n - 1)`. Gauss's formula uses
`range (n + 1)`:

```lean
theorem sum_id (n : ℕ) : ∑ i ∈ range (n + 1), i = n * (n + 1) / 2
```

(`open Finset` lets you write `range`.) A sum can also be defined by recursion:
`sumTo 0 = 0` and `sumTo (n + 1) = sumTo n + (n + 1)`.

## The Collatz map

One Collatz step halves an even number and sends an odd `n` to `3 n + 1`. The conjecture
says repeating it from any `n ≥ 1` reaches `1`. Nobody knows.

## Your task

Fill in `fac`, `fib`, `sumTo` and `collatz`, then state (don't prove):

* `sum_id`: Gauss's formula above, for all `n`, with `Finset.range`.
* `fac_ge`: for all `n`, `2 ^ (n - 1) ≤ n !`. Mathlib's factorial is
  `Nat.factorial n`, also written `n !` (with a space) after `open Nat`. State it with
  `Nat.factorial`, not with your `fac`.
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

statement sum_id : sorry

statement fac_ge : sorry

end L22
