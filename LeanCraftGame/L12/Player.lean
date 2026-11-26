/-
# Sequences and convergence

MIL §3.6 puts the whole chapter to work on one definition, convergence of a sequence of
reals:

```lean
def ConvergesTo (s : ℕ → ℝ) (a : ℝ) :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n - a| < ε
```

Read it aloud: for every tolerance `ε > 0` there is an index `N` from which on every
term is within `ε` of `a`. Every symbol matters:

* `ε > 0`: without it, `ε = 0` asks for `|s n - a| < 0`, which never holds, so no
  sequence would converge;
* `∃ N, ∀ n ≥ N`: from some point on, **every** term. With `∃ n` instead, one close term
  would be enough, and `0, 1, 0, 1, …` would "converge" to `0`;
* the order `∀ ε, ∃ N`: `N` may depend on `ε`.

MIL then proves three theorems about it. You will **state** them.

## Theorems about your definition

A statement can mention your own definitions, exactly as a Mathlib theorem mentions
Mathlib's:

```lean
statement convergesTo_const (a : ℝ) : ConvergesTo (fun _ ↦ a) a
```

`fun _ ↦ a` is the constant sequence `a, a, a, …` (the `_` is an index that is not used).

## Your task

1. Define `ConvergesTo s a`.
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
