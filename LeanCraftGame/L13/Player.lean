/-
# Be the referee

*Everyone at the Annex writes convergence from memory, and not always right. Would the
referee's tests catch them? This time you write the tests, and the referee tries to slip
wrong definitions past them.*

The right definition, for limit `0`:

```lean
def ConvergesTo0 (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n| < ε
```

Your test suite is four sequences: two that converge to 0 (`good₁`, `good₂`) and two that
don't (`bad₁`, `bad₂`).

The referee first checks your labels. Then it brings out the **mutants**: hidden wrong
definitions of convergence, the kind people write from memory. A mutant is caught when it
rejects a `good` sequence or accepts a `bad` one. A mutant that gets all four right
survives. This is *mutation testing*, and it's how this game's tests were chosen.

## Choosing good tests

Obvious examples like `fun _ ↦ 0` and `fun n ↦ n` catch little. Aim at the boundary:

* a sequence that converges even though it lacks a property people confuse with
  convergence (it isn't monotone, or isn't always positive);
* a sequence that doesn't converge even though it has such a property (it keeps coming
  back near `0`, or stays small, or stays below every `ε` but on the wrong side).

The referee computes, so use sequences that are eventually constant or alternate, like
Sam's `late` and `blink` from level 12 (`fun n ↦ if n < 5 then 7 else 0` and
`fun n ↦ if n % 2 = 0 then 0 else 1`), with small numbers (`1`, `2`, `1/2`, `-1`). Write
them out in full: the template doesn't know `late` and `blink`.

## Your task

Fill in the four sequences so that every mutant is caught. The report says how many
mutants there are. A ❌ on a mutant means the referee proved that your four sequences
can't tell it apart from the right definition, and it shows that mutant. The run stops
at the first one that survives.
-/
namespace L13

def ConvergesTo0 (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n| < ε

-- two sequences that converge to 0
def good₁ : ℕ → ℝ := sorry
def good₂ : ℕ → ℝ := sorry

-- two sequences that don't
def bad₁ : ℕ → ℝ := sorry
def bad₂ : ℕ → ℝ := sorry

end L13
