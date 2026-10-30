/-
# Spot the bug: limits

Two colleagues each wrote down the limit of a real sequence, from memory.
Both got it wrong, in opposite directions.

```lean
-- Alice: u converges to a
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε

-- Bob: u converges to a
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε
```

One of them is **too strong**: it rejects sequences that do converge. The other
is **too weak**: it accepts sequences that do not. Your first job is to work
out which is which. Compare each with the definition you wrote in "Limits":

```lean
def ConvergesTo (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ N, ∀ n ≥ N, |u n - a| < ε
```

Then find a counterexample for each: a sequence and a limit on which the
colleague's definition and the right one disagree.

Keep your sequences simple, so that the referee can check them: constants,
`if … then … else …`, and `n % 2` are all fine. Real numbers are written as
usual: `0`, `1`, `(1 / 2 : ℝ)`.

## Your task

* `seqA`, `limA`: a sequence that converges to `limA`, but that `ConvergesA`
  rejects.
* `seqB`, `limB`: a sequence that does not converge to `limB`, but that
  `ConvergesB` accepts.
-/
namespace L26

-- The colleagues' code, to read (the referee uses its own copy).
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε

-- converges to limA, but ConvergesA rejects it
def seqA : ℕ → ℝ := sorry
def limA : ℝ := sorry

-- does not converge to limB, but ConvergesB accepts it
def seqB : ℕ → ℝ := sorry
def limB : ℝ := sorry

end L26
