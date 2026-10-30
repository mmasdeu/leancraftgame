/-
# Going to infinity

You now have all the words of logic: `∀`, `∃`, `→`, `∧`, and shorthands such as
`∀ n ≥ N`. The Predicate world uses them for what mathematicians do all day:
turning an idea they have in their head into a definition that says exactly that.

A sequence of natural numbers is a function `u : ℕ → ℕ`: `u n` is its term
number `n`. Write down what it means for `u` to **tend to infinity**.

* Start from words, not symbols: "however large a bound `M` you choose, …".
  Then translate, and keep the quantifiers in the order the sentence has them.
  You saw in "Quantifiers in order" that the order changes the meaning.
* Only the meaning matters: the referee does not care how you write it, but it
  tests your definition on sequences that should tend to infinity, on sequences
  that should not, and on facts that anybody who *uses* the notion would need.
* Before your first run you will be asked to predict a few verdicts. Take your
  time with them: they are where the traps of the level are.
-/
import Mathlib.Tactic

namespace L19

def TendsToInfinity (u : Nat → Nat) : Prop :=
  sorry

end L19
