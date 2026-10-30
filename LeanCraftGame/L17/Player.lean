/-
# Bounded quantifiers

Mathematicians write "for all n ≥ N" and "there is an n > 0". Lean (with
Mathlib) has the same shorthand:

* `∀ n ≥ N, P n` means `∀ n, n ≥ N → P n`;
* `∃ n > 0, P n` means `∃ n, n > 0 ∧ P n`.

Notice the difference: the bound becomes an **implication** under `∀` and a
**conjunction** under `∃`. This is exactly the `→` versus `∧` lesson from
"If … then …". Writing the long form by hand with the wrong connective is a
classic mistake:

* `∃ n, n > 0 → f n = 0` is true for *every* `f`: take `n = 0`, then `0 > 0`
  is false, and an implication with a false premise is true.

The same shorthand exists for `≤`, `<`, `≠` and, as you will see with sets,
for `∈`. Several variables can share a quantifier: `∀ a b, …`.

```lean
def EventuallyBig (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, 10 ≤ u n
```

## Your task

`EventuallyBig` is done. Define `HasPositiveRoot f` and `EventuallyZero u`.
-/
namespace L17

-- from some index on, every term is at least 10 (already done)
def EventuallyBig (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, 10 ≤ u n

-- f is zero at some n other than 0
def HasPositiveRoot (f : ℕ → ℕ) : Prop := sorry

-- from some index on, every term is 0
def EventuallyZero (u : ℕ → ℕ) : Prop := sorry

end L17
