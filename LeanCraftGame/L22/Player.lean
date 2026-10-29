/-
# Limits

Time for the definition every analysis course starts with. Some new notation:

* `ℝ` (type `\R`) is the real numbers. A real sequence is `u : ℕ → ℝ`.
* `|x|` is the absolute value, written with the plain keyboard bar.
* Casts again: in `fun n => (n : ℝ)`, the natural number `n` is turned into a
  real number (displayed `↑n`).
* `ε` is typed `\e` (then a space), and `∀ ε > 0, …` is a bounded quantifier.

A real sequence `u` **converges** to `a` when: for every `ε > 0` there is an
index `N` such that every term from `N` on is within `ε` of `a`.

```lean
-- the worked example: the sequence stays within some bound
def BoundedSeq (u : ℕ → ℝ) : Prop := ∃ M, ∀ n, |u n| ≤ M
```

## What can go wrong

* Forgetting `ε > 0`: for `ε = 0` nothing is within distance 0, so no
  sequence converges.
* Writing `∃ n` instead of "for all `n ≥ N`": then `u` only needs to come close
  to `a` once.
* Putting `∃ N` before `∀ ε`: then a single `N` must work for every `ε`.

## Your task

`BoundedSeq` is done. Define `ConvergesTo u a`.
-/
namespace L22

-- some bound M is at least every |u n| (already done)
def BoundedSeq (u : ℕ → ℝ) : Prop := ∃ M, ∀ n, |u n| ≤ M

-- u converges to a: for every ε > 0, from some index N on,
-- every term u n is within ε of a
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := sorry

end L22
