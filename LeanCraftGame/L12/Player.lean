/-
# Sequences and convergence

*The project's main definition: convergence of a sequence. It uses every quantifier so
far, and Noor has seen it written wrong in every way. Sam keeps two test sequences pinned
above the desk.*

```lean
def ConvergesTo (s : ℕ → ℝ) (a : ℝ) :=
  ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n - a| < ε

def late : ℕ → ℝ := fun n ↦ if n < 5 then 7 else 0      -- 7, 7, 7, 7, 7, 0, 0, …
def blink : ℕ → ℝ := fun n ↦ if n % 2 = 0 then 0 else 1  -- 0, 1, 0, 1, …
```

For every tolerance `ε > 0` there is an index `N` after which every term is within `ε`
of `a`. Every symbol matters:

* `ε > 0`: without it, `ε = 0` asks for `|s n - a| < 0`, which never holds, so no sequence
  would converge.
* `∃ N, ∀ n ≥ N`: from some point on, every term is close, whatever the first terms do.
  With `∃ n` instead, one close term would be enough, and `blink` would "converge" to `0`.
* The order `∀ ε, ∃ N`: `N` may depend on `ε`.

## Theorems about your definition

You'll also state three theorems. A statement can use your own definitions:

```lean
statement convergesTo_const (a : ℝ) : ConvergesTo (fun _ ↦ a) a
```

`fun _ ↦ a` is the constant sequence `a, a, a, …` (the `_` is an unused index).

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
