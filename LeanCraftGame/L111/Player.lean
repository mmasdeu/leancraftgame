/-
# Cauchy sequences

In "Limits" a sequence converged to a number `a` that you named in advance.
Sometimes you cannot name it, and you only know that the terms **crowd together**:
a real sequence `u : ℕ → ℝ` is a **Cauchy sequence** when for every `ε > 0` there
is an index `N` such that any two terms from `N` on are within `ε` of each other.
(Over the reals, Cauchy sequences are exactly the convergent ones.)

Notation, all seen before: `∀ ε > 0, …`, `∀ n ≥ N, …`, `|x|`, and `(n : ℝ)` for the
real number with the same value as `n : ℕ`.

```lean
-- the worked example: u converges to a
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
```

Note the difference: here `ε` is compared with the distance between *two terms*,
`|u m - u n|`, and *both* indices have to be beyond `N`.

## What can go wrong

* "Two terms" means *any* two: `m` and `n` each range over all indices `≥ N`, with
  `∀`, not `∃`.
* Both must be `≥ N`. An early wild term must not spoil the sequence: the first
  terms never matter.
* `ε > 0`, as always, and `N` is chosen after `ε`.

## Your task

`ConvergesTo` is done. First a warm-up: `IsEventuallyConstant u` says that from
some index on, `u` takes one single value. Then `IsCauchy u`.
-/
namespace L111

-- u converges to a (already done)
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε

-- from some index N on, every term equals u N
def IsEventuallyConstant (u : ℕ → ℝ) : Prop := sorry

-- u is a Cauchy sequence: for every ε > 0, from some index N on,
-- any two terms are within ε of each other
def IsCauchy (u : ℕ → ℝ) : Prop := sorry

end L111
