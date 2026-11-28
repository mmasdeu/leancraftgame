/-
# Sequences and convergence

*The project's main definition: convergence of a sequence. It uses every quantifier so
far, and Noor has seen it written wrong in every way. Sam keeps two test sequences pinned
above the desk.*

A sequence of reals is a function `s : ℕ → ℝ`, and `s n` is its `n`-th term. Here is a
cousin of convergence, "`s` tends to `+∞`":

```lean
def TendsToInfinity (s : ℕ → ℝ) : Prop :=
  ∀ M : ℝ, ∃ N : ℕ, ∀ n ≥ N, M < s n
```

For every height `M` there is an index `N` from which on every term is above `M`. As in
level 8, `∀ n ≥ N, …` is short for `∀ n, n ≥ N → …`, and `∀ ε > 0, …` works the same
way. Indices are natural numbers, so Lean knows `N : ℕ` without being told.

Sam's two test sequences:

```lean
def late : ℕ → ℝ := fun n ↦ if n < 5 then 7 else 0      -- 7, 7, 7, 7, 7, 0, 0, …
def blink : ℕ → ℝ := fun n ↦ if n % 2 = 0 then 0 else 1  -- 0, 1, 0, 1, …
```

`if c then x else y` is `x` when `c` holds and `y` otherwise. `n % 2` is the remainder of
`n` divided by `2`.

## Theorems about your definition

You'll also state three theorems. A statement can use your own definitions:

```lean
statement tendsToInfinity_add (s : ℕ → ℝ) (c : ℝ) (h : TendsToInfinity s) :
    TendsToInfinity (fun n ↦ s n + c)
```

`fun _ ↦ a` is the constant sequence `a, a, a, …` (the `_` is an unused index).

## Your task

1. Define `ConvergesTo s a`: `s` converges to `a`, with the usual `ε`-`N` definition.
2. `convergesTo_const`: for every real `a`, the constant sequence `a` converges to `a`.
3. `convergesTo_add`: for all sequences `s t` and reals `a b` (in this order), if `s`
   converges to `a` and `t` converges to `b`, then `fun n ↦ s n + t n` converges to
   `a + b`.
4. `convergesTo_unique`: for every sequence `s` and reals `a b`, if `s` converges to `a`
   and to `b`, then `a = b`.
-/
namespace L12

def ConvergesTo (s : ℕ → ℝ) (a : ℝ) : Prop := sorry

statement convergesTo_const : sorry

statement convergesTo_add : sorry

statement convergesTo_unique : sorry

end L12
