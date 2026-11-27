/-
# Spot the bug: logic

*Before the Logic project closes, Noor goes through Sam's notebook. Four definitions,
written from memory; each compiles, and each is wrong. Sam asks for one example per
definition, "so I can see it fail".*

```lean
-- convergence, without `ε > 0`
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε

-- convergence, where one close term is enough
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε

-- "some term of u is positive", with an implication under ∃
def SomePositive (u : ℕ → ℝ) : Prop := ∃ n, n > 0 → u n > 0

-- "f is bounded above", with the quantifiers swapped
def BoundedAbove (f : ℝ → ℝ) : Prop := ∀ x, ∃ M, f x ≤ M
```

A wrong definition is either **too strong** (it rejects something it should accept) or
**too weak** (it accepts something it should reject), and one example shows it:

* `ConvergesA` is too strong. Give a sequence and a limit that converge in the right
  sense, which it rejects. (Try `ε = 0`.)
* `ConvergesB` is too weak. Give a sequence and a limit that do *not* converge, which
  it accepts. Sam's own test sequences from level 12 are a good place to look.
* `SomePositive` is too weak. Give a sequence with **no** positive term that it accepts.
* `BoundedAbove` is too weak. Give a function that is **not** bounded above that it
  accepts.

The referee checks both halves of each claim, with the right definitions. Use
eventually constant or alternating sequences and small numbers, so that the referee can
compute.
-/
namespace L14

def seqA : ℕ → ℝ := sorry
def limA : ℝ := sorry

def seqB : ℕ → ℝ := sorry
def limB : ℝ := sorry

def seqC : ℕ → ℝ := sorry

def funD : ℝ → ℝ := sorry

end L14
