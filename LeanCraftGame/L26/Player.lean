/-
# Sequences that come back

How often does a sequence take the value `a`?

* **eventually equal** to `a`: from some index on, always `a`.
* **infinitely often** `a`: for every `N`, some later index has value `a`
  (`∀ N, ∃ n ≥ N, u n = a`). Equivalently, the set of indices is
  infinite.
* **only finitely often**: the negation of infinitely often. Write it as
  "from some index on, never `a`".

These are the two basic "sizes" of a set of indices, and they are dual:
"eventually `P`" is "not infinitely often not `P`". The pair reappears in
probability (Borel–Cantelli: `lim sup` and `lim inf` of events), in dynamics
(Poincaré recurrence), and in topology as two filters on `ℕ`.

A sequence is **recurrent** when every value it takes, it takes infinitely
often: `0, 1, 0, 1, …` is recurrent, `0, 1, 1, 1, …` is not.

## Your task

Define `EventuallyEqual`, `InfinitelyOften`, `OnlyFinitelyOften` and
`Recurrent`.
-/
import Mathlib.Tactic

namespace L26

def EventuallyEqual (u : ℕ → ℕ) (a : ℕ) : Prop :=
  sorry

def InfinitelyOften (u : ℕ → ℕ) (a : ℕ) : Prop :=
  sorry

def OnlyFinitelyOften (u : ℕ → ℕ) (a : ℕ) : Prop :=
  sorry

def Recurrent (u : ℕ → ℕ) : Prop :=
  sorry

end L26
