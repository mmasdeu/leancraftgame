/-
# Spot the bug: quantifiers

Three definitions from a colleague, each with a classic quantifier error.
Translate each one *literally* back into words before deciding what it says.

* `∃ n, n > 0 → f n = 0`: an existential with an implication inside. What
  happens with `n = 0`?
* `∀ N, ∃ n ≥ N, u n = 0`: "for every `N` there is a later zero". That is
  "**infinitely often**", not "eventually".
* `∃ M, ∀ n, M ≤ u n`: a lower bound, not unboundedness. Every sequence of
  natural numbers satisfies it with `M = 0`.

To refute such a definition you need a **function**, not a number: a
sequence that the colleague's definition accepts and the intended one
rejects. Write it with `fun`, or with `if … then … else`.

## Your task

For each definition, give a sequence on which it is wrong. Each test is a
claim about your sequence that must be true; the referee proves it.
-/
namespace L22

-- The colleague's code, to read (the referee uses its own copy).
def HasPositiveRoot (f : ℕ → ℕ) : Prop := ∃ n, n > 0 → f n = 0
def EventuallyZero (u : ℕ → ℕ) : Prop := ∀ N, ∃ n ≥ N, u n = 0
def Unbounded (u : ℕ → ℕ) : Prop := ∃ M, ∀ n, M ≤ u n

-- accepted by HasPositiveRoot, but no root other than 0
def noRoot : ℕ → ℕ := sorry

-- accepted by EventuallyZero, but not eventually 0
def notEventuallyZero : ℕ → ℕ := sorry

-- accepted by Unbounded, but bounded
def bounded : ℕ → ℕ := sorry

end L22
