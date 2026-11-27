/-
# Be the referee

*Everyone at the Annex writes convergence from memory, and not everyone gets it right.
Noor's question for you: are the referee's tests good enough to catch them? So far the
referee tested *your* definitions. Now you write the tests, and the referee tries to
slip wrong definitions past them.*

Here is the right definition, for limit `0`:

```lean
def ConvergesTo0 (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n| < ε
```

Your test suite is four sequences:

* two that **do** converge to 0 (`good₁`, `good₂`), and
* two that do **not** (`bad₁`, `bad₂`).

The referee first checks that your labels are honest. Then it brings out the
**mutants**: hidden *wrong* definitions of convergence, of the kind people write from
memory. A mutant is **caught** when it gets at least one of your sequences wrong: it
rejects a `good` one, or accepts a `bad` one. A mutant that gets all four right
**survives**: your tests cannot tell it apart from the right definition. This is
*mutation testing*, and it is how the tests of this game were chosen.

## Choosing good tests

A suite of obvious examples (`fun _ ↦ 0` and `fun n ↦ n`) catches little. Each probe
should sit **on the boundary** of the notion:

* a sequence that converges *despite* lacking a property people confuse with
  convergence (it is not monotone; it is not always positive);
* a sequence that does not converge *despite* having such a property (it comes close
  to `0` again and again; it stays small; it stays below every `ε`, but on the wrong
  side).

The referee proves things about sequences by computing, so use sequences that are
**eventually constant** or that **alternate**, like Sam's `late` and `blink` from
level 12 (`fun n ↦ if n < 5 then 7 else 0` and `fun n ↦ if n % 2 = 0 then 0 else 1`),
and small numbers (`1`, `2`, `1/2`, `-1`). Write them out in full: the template does
not know `late` and `blink`.

## Your task

Fill in the four sequences so that every mutant is caught. The report says how many
mutants there are; a mutant that survives is revealed, with its definition.
-/
namespace L13

def ConvergesTo0 (s : ℕ → ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |s n| < ε

-- two sequences that converge to 0
def good₁ : ℕ → ℝ := sorry
def good₂ : ℕ → ℝ := sorry

-- two sequences that do not
def bad₁ : ℕ → ℝ := sorry
def bad₂ : ℕ → ℝ := sorry

end L13
