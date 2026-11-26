/-
# Spot the bug: logic

Four colleagues wrote definitions from memory. Each compiles; each is wrong.

```lean
-- Alice: convergence, but she forgot `ε > 0`
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε

-- Bob: convergence, but one close term is enough for him
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε

-- Carol: "some term of u is positive", with an implication under ∃
def SomePositive (u : ℕ → ℝ) : Prop := ∃ n, n > 0 → u n > 0

-- Dan: "f is bounded above", with the quantifiers swapped
def BoundedAbove (f : ℝ → ℝ) : Prop := ∀ x, ∃ M, f x ≤ M
```

A wrong definition is either **too strong** (it rejects something it should accept) or
**too weak** (it accepts something it should reject), and one example shows it:

* Alice's is too strong. Give a sequence and a limit that converge in the right sense,
  which her definition rejects. (Try `ε = 0`.)
* Bob's is too weak. Give a sequence and a limit that do *not* converge, which his
  definition accepts.
* Carol's is too weak. Give a sequence with **no** positive term that she accepts.
* Dan's is too weak. Give a function that is **not** bounded above that he accepts.

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
