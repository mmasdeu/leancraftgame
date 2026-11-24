/-
# Going to infinity

"`u n` tends to infinity" is the first genuine definition of analysis, and
it already has three quantifiers:

> for every bound `M`, from some index `N` on, every term is at least `M`.

Compare it with its neighbours:

* **unbounded**: for every `M`, *some* term is at least `M`. The sequence
  `0, 1, 0, 2, 0, 3, …` is unbounded but does not tend to infinity: it
  keeps coming back to `0`.
* **increasing and unbounded**: this implies tending to infinity, but not
  conversely (`0, 2, 1, 3, 2, 4, …` tends to infinity and is not monotone).
* **`u n ≥ n`**: sufficient, not necessary (`n / 2` tends to infinity).

A definition must capture exactly the intended class: neither a
sufficient condition nor a necessary one. The referee tests your
definition on sequences that separate these notions.

The Collatz map is a test case for intuition: does the orbit of `n` tend
to infinity for some `n`? Nobody knows; but `fun n => iter n 27` certainly
does not, since it ends in the cycle `4, 2, 1`.

## Your task

Define `TendsToInfinity u`.
-/
import Mathlib.Tactic

namespace L23

def TendsToInfinity (u : Nat → Nat) : Prop :=
  sorry

end L23
