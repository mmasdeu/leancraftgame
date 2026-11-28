/-
# Spot the bug: logic

*Before the Logic project closes, Noor goes through Sam's notebook. Four definitions,
written from memory, are in the editor. Each compiles, and each is wrong. Sam asks for
one example per definition, "so I can see it fail".*

A wrong definition is either **too strong** (it rejects something it should accept) or
**too weak** (it accepts something it should reject). One example shows it.

## Your task

Read Sam's definitions in the editor (don't change them), then fill in the examples.

* `ConvergesA` is too strong. Give a sequence `seqA` and a limit `limA` that really
  converge, which it rejects.
* `ConvergesB` is too weak. Give a sequence `seqB` and a limit `limB` that don't converge,
  which it accepts. Sam's test sequences from level 12, `late` and `blink`, are a good
  place to look.
* `SomePositive` is too weak. Give a sequence `seqC` with no positive term that it
  accepts.
* `BoundedAbove` is too weak. Give a function `funD` that isn't bounded above that it
  accepts.

The referee checks both halves of each claim: that your example really does (or doesn't)
converge or have the property, and that Sam's definition gets it wrong. Use eventually
constant or alternating sequences and small numbers, so it can compute.
-/
namespace L15

-- Sam's code (don't edit)

-- u converges to a
def ConvergesA (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε, ∃ N, ∀ n ≥ N, |u n - a| < ε

-- u converges to a
def ConvergesB (u : ℕ → ℝ) (a : ℝ) : Prop := ∀ ε > 0, ∃ n, |u n - a| < ε

-- some term of u is positive
def SomePositive (u : ℕ → ℝ) : Prop := ∃ n, n > 0 → u n > 0

-- f is bounded above
def BoundedAbove (f : ℝ → ℝ) : Prop := ∀ x, ∃ M, f x ≤ M

-- Your examples

def seqA : ℕ → ℝ := sorry
def limA : ℝ := sorry

def seqB : ℕ → ℝ := sorry
def limB : ℝ := sorry

def seqC : ℕ → ℝ := sorry

def funD : ℝ → ℝ := sorry

end L15
