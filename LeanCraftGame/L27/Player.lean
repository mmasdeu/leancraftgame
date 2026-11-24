/-
# Be the referee

Until now the referee has tested your definitions. In this level you write
the tests.

The right definition of "tends to infinity" is given:

```lean
def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n
```

Your test suite is four sequences:

* two that **do** tend to infinity (`good₁`, `good₂`), and
* two that do **not** (`bad₁`, `bad₂`).

The referee first checks that your labels are honest: each `good` sequence
must really tend to infinity, and each `bad` one must really not.

Then it brings out the **mutants**: hidden *wrong* definitions of
`TendsToInfinity`, the plausible near-misses of the previous levels
(unbounded, increasing, at least the identity, eventually positive, …). A
mutant is **caught** when it gets at least one of your four sequences wrong:
it rejects a `good` one, or accepts a `bad` one. A mutant that gets all four
right **survives**: your examples cannot tell it apart from the right
definition.

This is how a mathematician chooses examples: not the typical case, but the
case that separates two notions. A sufficient condition is exposed by a
`good` sequence that violates it; a necessary condition by a `bad` sequence
that satisfies it. It is also how the levels of this game were built.
-/
namespace L27

-- the right definition (already done)
def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n

-- two sequences that tend to infinity
def good₁ : ℕ → ℕ := sorry
def good₂ : ℕ → ℕ := sorry

-- two sequences that do not
def bad₁ : ℕ → ℕ := sorry
def bad₂ : ℕ → ℕ := sorry

end L27
