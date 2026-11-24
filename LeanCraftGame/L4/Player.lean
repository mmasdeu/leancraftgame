/-
# Recursion

Sequences defined by induction are defined in Lean by **recursion**: give
the value at `0`, and the value at `n + 1` in terms of the value at `n`.

```lean
def factorial : Nat → Nat
  | 0 => 1
  | n + 1 => (n + 1) * factorial n
```

Each line `| pattern => value` is one case. Lean accepts the definition
because every recursive call is on a smaller input (`n` is smaller than
`n + 1`), so the computation terminates: this is induction, run backwards.

A function of two inputs can recurse on one of them. To iterate a map `k`
times, apply it once and then iterate `k - 1` more times:
`iter (k + 1) n = iter k (collatz n)`.

Some starting values take a long time to reach `1` under the Collatz map:
`27` needs 111 steps, climbing as high as 9232 on the way.

## Your task

Fill in the cases of `iter`, `fib` and `oddSum`. The referee checks values,
Cassini's identity `F(n)F(n+2) = F(n+1)² ± 1`, and that the sum of the first
`n` odd numbers is `n²` (for `n < 30`: computing is not proving, but it is
how one finds the theorem).
-/

namespace L4

-- the Collatz map (done)
def collatz (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1

-- the Collatz map applied k times to n:  iter 0 n = n,  iter 1 n = collatz n, …
def iter : Nat → Nat → Nat
  | 0, n => sorry
  | k + 1, n => sorry

-- the Fibonacci numbers 0, 1, 1, 2, 3, 5, 8, …
def fib : Nat → Nat
  | 0 => sorry
  | 1 => sorry
  | n + 2 => sorry

-- the sum 1 + 3 + 5 + ⋯ + (2n - 1) of the first n odd numbers
def oddSum : Nat → Nat
  | 0 => sorry
  | n + 1 => sorry

end L4
