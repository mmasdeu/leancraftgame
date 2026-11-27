/-
# Recursion and induction

*Level 18 read a definition by recursion, `sbAux`. Now the Annex needs its own: Noor asks
for factorials, Fibonacci numbers and sums for the counting project ahead, and for the
facts about them stated, ready for the Prover. Facts about recursive definitions are
proved by induction; you only state them.*

## Pattern matching

```lean
def fac : ℕ → ℕ
  | 0 => 1
  | n + 1 => (n + 1) * fac n
```

There is no `:=`: each line `| pattern => value` covers one shape of the argument. A
natural number is either `0` or `n + 1` for some `n`, so these two lines cover
everything, and `fac (n + 1)` may call `fac n`. The `0` line is the one to think about:
every other value is built from it. Patterns can
go deeper:

```lean
def fib : ℕ → ℕ
  | 0 => 0
  | 1 => 1
  | n + 2 => fib n + fib (n + 1)
```

## Sums: `∑ i ∈ Finset.range n, f i`

`Finset.range n` is the finite set `{0, 1, …, n - 1}`: it has `n` elements, and it does
**not** contain `n`. So `∑ i ∈ Finset.range n, i` is `0 + 1 + ⋯ + (n - 1)`. The classic
first proof by induction is Gauss's formula, with `range (n + 1)`:

```lean
theorem sum_id (n : ℕ) : ∑ i ∈ range (n + 1), i = n * (n + 1) / 2
```

(`open Finset` lets you write `range` for `Finset.range`.) A sum can also be defined by
recursion: `sumTo 0 = 0` and `sumTo (n + 1) = sumTo n + (n + 1)`.

## The Collatz map

One step of the Collatz map halves an even number and sends an odd `n` to `3 n + 1`. The
Collatz conjecture says that iterating it from any `n ≥ 1` reaches `1`; nobody knows.

## Your task

Fill in `fac`, `fib`, `sumTo` and `collatz`, then state two facts (do not prove them):

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
