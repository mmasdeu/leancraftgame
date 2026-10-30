/-
# Bounded and monotone

Sequences of integers `u : ℕ → ℤ`. Four properties to define, and each has
a plausible-looking wrong version.

* `BoundedAbove u`: some number `M` is at least every term.
* `Bounded u`: the terms stay in a band, **on both sides**. Use the absolute
  value `|x|` (type `|`, then `x`, then `|`).
* `NonDecreasing u`: the sequence never goes down, **between any two
  positions**: if `m ≤ n` then `u m ≤ u n`.
* `StrictlyIncreasing u`: the same with `<` everywhere: if `m < n` then
  `u m < u n`.

Take `M` to be a natural number (`∃ M : ℕ, …`); Lean inserts the cast
`(M : ℤ)` for you, so you can write `u n ≤ M`. Remember that quantifier order
matters: `∃ M, ∀ n, …` says one `M` works for every `n`.

```lean
def Constant (u : ℕ → ℤ) : Prop := ∀ m n, u m = u n
```

The referee will try your definitions on sequences such as `fun n => -(n : ℤ)`
(0, -1, -2, …) and `fun n => if n < 3 then (n : ℤ) else 0` (0, 1, 2, 0, 0, …).
Press **Run tests** to see the report.

Hint: check each definition on a sequence that goes down forever, on one
that stays level, and on one that goes up at first and then falls back.
-/
import Mathlib.Tactic

namespace L105

def BoundedAbove (u : ℕ → ℤ) : Prop :=
  sorry

def Bounded (u : ℕ → ℤ) : Prop :=
  sorry

def NonDecreasing (u : ℕ → ℤ) : Prop :=
  sorry

def StrictlyIncreasing (u : ℕ → ℤ) : Prop :=
  sorry

end L105
