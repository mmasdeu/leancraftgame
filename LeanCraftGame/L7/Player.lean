/-
# Spot the bug: statements

*Sam's contribution to the AM-GM project arrives late on Friday: three statements, typed
fast, all of which compile. Noor asks you to check them before they reach the Prover,
which would spend the weekend failing to prove them: each of the three is **false**.
Your job is to show it, then repair what can be repaired.*

```lean
-- Sam's statements
statement sub_sq_nat (a b : ℕ) : (a - b) ^ 2 = a ^ 2 - 2 * a * b + b ^ 2

statement sq_le_sq_of_le (a b : ℝ) (hab : a ≤ b) : a ^ 2 ≤ b ^ 2

statement div_mul_cancel_bad (x y : ℝ) : x / y * y = x
```

A false statement about *all* numbers is refuted by **one** counterexample: values of the
variables that satisfy every hypothesis and break the conclusion. Usual suspects:

* **truncated subtraction**: in `ℕ`, `a - b = 0` when `a ≤ b`;
* a **missing hypothesis**: here, a sign condition;
* **junk values**: Mathlib defines `x / 0 = 0` for every `x`, so that division is a
  function on all of `ℝ`. Theorems about division therefore carry a hypothesis `y ≠ 0`.

## Part A: counterexamples

Give the values. The referee checks that they satisfy the hypotheses and break the
conclusion. Small numbers suffice (the referee computes, it does not search).

## Part B: repairs

State the two real-number facts correctly, by **adding** the missing hypothesis (and
nothing else). Name the hypotheses as you like.
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
