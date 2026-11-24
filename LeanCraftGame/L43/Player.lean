/-
# Spot the bug: limits

Two colleagues wrote the definition of convergence from memory.

* Alice wrote `∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε`: she forgot `ε > 0`. Is her
  definition too strong or too weak? Try `ε = 0`.
* Bob wrote `∀ ε > 0, ∃ n, |u n - a| < ε`: one close term suffices for him.
  Too strong or too weak?

A definition that is too strong rejects some convergent sequence; to refute
it, give a sequence that converges, and the referee shows that Alice's
definition rejects it. A definition that is too weak accepts a sequence that
does not converge; give one that Bob accepts.

Real sequences are written with `fun n => …`; `(n : ℝ)` casts the index,
and `if … then … else …` works as for ℕ.

## Your task

Give a sequence and a limit for each colleague.
-/
namespace L43

-- The colleagues' code, to read (the referee uses its own copy).
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε

-- converges to limA, but ConvergesA rejects it
def seqA : ℕ → ℝ := sorry
def limA : ℝ := sorry

-- does not converge to limB, but ConvergesB accepts it
def seqB : ℕ → ℝ := sorry
def limB : ℝ := sorry

end L43
