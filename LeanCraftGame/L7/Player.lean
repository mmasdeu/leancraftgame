/-
# Spot the bug: statements

*Sam's part of the AM-GM project arrives late on Friday: three statements, typed fast. All
three compile, and all three are false. Noor asks you to show it before they reach the
Prover, then repair what can be repaired.*

```lean
-- Sam's statements
statement sub_sq_nat (a b : ℕ) : (a - b) ^ 2 = a ^ 2 - 2 * a * b + b ^ 2

statement sq_le_sq_of_le (a b : ℝ) (hab : a ≤ b) : a ^ 2 ≤ b ^ 2

statement div_mul_cancel_bad (x y : ℝ) : x / y * y = x
```

One **counterexample** refutes a statement about all numbers: values that satisfy every
hypothesis and break the conclusion. Usual suspects:

* truncated subtraction: in `ℕ`, `a - b = 0` when `a ≤ b`;
* a missing hypothesis, here a sign condition;
* junk values: Mathlib sets `x / 0 = 0`, so division works on all of `ℝ`. Theorems about
  division need a hypothesis `y ≠ 0`.

## Part A: counterexamples

Give the values. The referee checks that they satisfy the hypotheses and break the
conclusion. Use small numbers: the referee computes, it doesn't search.

## Part B: repairs

State the two real-number facts correctly by adding the missing hypothesis, and nothing
else. Name the hypotheses as you like.
-/
namespace L7

-- Part A
def a₁ : ℕ := sorry
def b₁ : ℕ := sorry

def a₂ : ℝ := sorry
def b₂ : ℝ := sorry

def x₃ : ℝ := sorry
def y₃ : ℝ := sorry

-- Part B
statement sq_le_sq_of_le : sorry

statement div_mul_cancel_ok : sorry

end L7
