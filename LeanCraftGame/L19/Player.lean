/-
# Going to infinity

Write down what it means for a sequence of natural numbers `u : ℕ → ℕ`
to tend to infinity.

You never write a proof in this game. The referee is an automated prover:
it takes a battery of hidden tests about your definition (sequences that
should tend to infinity, sequences that should not, and lemmas a user of
your definition will need) and tries to prove or refute each one.

Press **Run tests** to see the report.

Hint: think about the sequence 0, 4, 2, 6, 4, 8, … Does it tend to
infinity? Would your definition say so?
-/
import Mathlib.Tactic

namespace L19

def TendsToInfinity (u : Nat → Nat) : Prop :=
  sorry

end L19
