/-
# Bounded and monotone

The monotone convergence theorem says that a bounded monotone sequence of
reals converges. Both hypotheses are definitions, and both come in
variants that are easy to confuse. We use integer-valued sequences
`u : ℕ → ℤ`, so that "bounded below" is a real condition.

* **bounded above**: some `M` is at least every term (`∃ M, ∀ n, u n ≤ M`:
  one `M` for all `n`, so `∃` comes first).
* **bounded**: bounded above *and* below. With integers, "`|u n| ≤ M` for
  some `M`" is equivalent.
* **non-decreasing**: `m ≤ n → u m ≤ u n` for all `m`, `n`. Comparing
  consecutive terms, `u n ≤ u (n + 1)`, is equivalent (by induction), and
  the referee accepts either.
* **strictly increasing**: `m < n → u m < u n`.

Constant sequences are non-decreasing and not strictly increasing: a
boundary case worth predicting.

## Your task

Define `BoundedAbove`, `Bounded`, `NonDecreasing` and `StrictlyIncreasing`.
-/
import Mathlib.Tactic

namespace L24

def BoundedAbove (u : ℕ → ℤ) : Prop :=
  sorry

def Bounded (u : ℕ → ℤ) : Prop :=
  sorry

def NonDecreasing (u : ℕ → ℤ) : Prop :=
  sorry

def StrictlyIncreasing (u : ℕ → ℤ) : Prop :=
  sorry

end L24
