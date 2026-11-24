/-
# Bounded quantifiers and "eventually"

Lean writes restricted quantifiers in short form:

* `∀ n ≥ N, P n` means `∀ n, n ≥ N → P n` (an implication);
* `∃ n > 0, P n` means `∃ n, n > 0 ∧ P n` (a conjunction).

The asymmetry is forced: "some positive `n` has `P`" is not `∃ n, n > 0 →
P n`, which is true as soon as `n = 0` is plugged in (the hypothesis is
false). The short forms are there so that you do not have to remember.

"**Eventually**" combines the two quantifiers: from some index on, always.

```lean
def EventuallyBig (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, 10 ≤ u n
```

This `∃ N, ∀ n ≥ N` pattern is the heart of every limit in analysis, and in
the Topology world it becomes a *filter*: the family of sets that contain a
tail `{N, N + 1, …}`.

## Your task

Define `HasPositiveRoot f` (`f` vanishes at some `n` other than `0`) and
`EventuallyZero u` (from some index on, every term is `0`).
-/
namespace L20

-- from some index on, every term is at least 10 (already done)
def EventuallyBig (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, 10 ≤ u n

-- f is zero at some n other than 0
def HasPositiveRoot (f : ℕ → ℕ) : Prop := sorry

-- from some index on, every term is 0
def EventuallyZero (u : ℕ → ℕ) : Prop := sorry

end L20
