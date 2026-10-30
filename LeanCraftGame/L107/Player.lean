/-
# Sequences that come back

Sequences of natural numbers `u : ℕ → ℕ`, and the difference between two
small words: **eventually** and **infinitely often**.

* `EventuallyEqual u a`: from some index on, every term is `a`.
  The shape is `∃ N, ∀ n ≥ N, …`.
* `InfinitelyOften u a`: the value `a` appears again and again: however far
  you walk, you meet it later. The shape is `∀ N, ∃ n ≥ N, …`.
* `OnlyFinitelyOften u a`: the value `a` stops appearing at some point
  (write it *without* a negation in front of a quantifier, by pushing the
  `¬` inside).
* `Recurrent u`: the sequence comes back to its **starting value** `u 0`
  infinitely often.

```lean
def Positive (u : ℕ → ℕ) : Prop := ∀ n, 0 < u n
def EventuallyPositive (u : ℕ → ℕ) : Prop := ∃ N, ∀ n ≥ N, 0 < u n
```

`∀ n ≥ N, P n` is short for `∀ n, n ≥ N → P n`, and `∃ n ≥ N, P n` for
`∃ n, n ≥ N ∧ P n`. Type `≥` as `\ge`.

The referee will try your definitions on sequences such as `fun n => n % 2`
(0, 1, 0, 1, …), `fun n => if n < 5 then 7 else 0` (7, 7, 7, 7, 7, 0, 0, …)
and `fun n => if n % 2 = 0 then 0 else n` (0, 1, 0, 3, 0, 5, …).
Press **Run tests** to see the report.

Hint: a value met *once*, a value met *infinitely often* and a value the
sequence *ends up equal to* are three different things. Which of the
sequences above shows each of them?
-/
import Mathlib.Tactic

namespace L107

def EventuallyEqual (u : ℕ → ℕ) (a : ℕ) : Prop :=
  sorry

def InfinitelyOften (u : ℕ → ℕ) (a : ℕ) : Prop :=
  sorry

def OnlyFinitelyOften (u : ℕ → ℕ) (a : ℕ) : Prop :=
  sorry

def Recurrent (u : ℕ → ℕ) : Prop :=
  sorry

end L107
