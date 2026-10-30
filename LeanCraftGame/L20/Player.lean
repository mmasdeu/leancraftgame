/-
# Be the referee

In "Going to infinity" the referee tested *your* definition. Now you write
the tests, and the referee tries to slip wrong definitions past them.

Here is the right definition, from that level:

```lean
def TendsToInfinity (u : ℕ → ℕ) : Prop := ∀ M, ∃ N, ∀ n ≥ N, M ≤ u n
```

Your test suite is four sequences:

* two that **do** tend to infinity (`good₁`, `good₂`), and
* two that do **not** (`bad₁`, `bad₂`).

The referee first checks that your labels are honest: each `good` sequence
must really tend to infinity, and each `bad` one must really not.

Then it brings out the **mutants**: hidden *wrong* definitions of
`TendsToInfinity`, like the ones players write by mistake. A mutant is
**caught** when it gets at least one of your four sequences wrong: it rejects a
`good` one, or accepts a `bad` one. A mutant that gets all four right
**survives**: your tests cannot tell it apart from the right definition, so a
wrong definition would have cleared your level.

Software testers call this *mutation testing*. It is also how the levels of
this game were made: every test you have met was chosen to catch a mistake.

## Choosing good tests

A test suite of obvious examples (`fun n => n` and `fun _ => 0`) catches very
little. Each probe should sit **on the boundary** of the notion:

* a sequence that tends to infinity *despite* lacking a property that people
  confuse with it;
* a sequence that does not, *despite* having such a property.

Think back to "Going to infinity": which properties are *not* part of the
notion, but are easy to mistake for it?

## Your task

Fill in the four sequences so that every mutant is caught. The report shows
how many mutants are hidden. A mutant that survives is revealed, with its
definition, so that you can see what your suite missed.
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
