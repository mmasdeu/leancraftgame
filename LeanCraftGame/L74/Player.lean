/-
# The AI proved the Collatz conjecture!

The Collatz map has followed us since the Foundations world: `27` takes
111 steps to reach `1`, and nobody knows whether every start does. Now an
AI claims a proof, and Lean accepts it.

The proof is one line, `fun n => ⟨0, le_refl n⟩`. A one-line proof of a
famous open problem is not a breakthrough; it is evidence that the
statement is not the problem. Read it: "for every `n` there is `k` with
`orbit n k ≤ n`". Take `k = 0`.

Two auditor's tools:

* **Parametrise the statement** by the process, so that it can be
  evaluated in toy processes where you know the answer: a faithful
  statement must be false in a process that gets stuck, and the AI's
  statement is true in it.
* **Check the boundary**: does the conjecture hold for `n = 0`? The
  Collatz map fixes `0` (you found that in the Logic world), so the real
  statement must say "positive".

Your task is in the comments of the file below.
-/
import Mathlib.Tactic

namespace L74

def step (n : Nat) : Nat := if n % 2 = 0 then n / 2 else 3 * n + 1

/-- The number reached after `k` steps from `n`. -/
def orbit (n k : Nat) : Nat := step^[k] n

/-- The AI's claim, for any process `o`. -/
def AIClaim (o : Nat → Nat → Nat) : Prop := ∀ n, ∃ k, o n k ≤ n

theorem ai_collatz : AIClaim orbit := fun n => ⟨0, le_refl n⟩

/-
Your task has three parts.

1. `Collatz o`: the faithful statement, for any process `o`: *from every
   positive start `n`, some step `k` has `o n k` exactly equal to 1.*
   (`Collatz orbit` is then the real conjecture.)
2. `lazyWorld : Nat → Nat → Nat`: a process in which the AI's claim holds
   but the real claim fails. It must be a process: `lazyWorld n 0 = n`.
   Keep it simple (sums, differences, `if`): the referee has to be able
   to check it.
3. `stuckStart : Nat`: a starting number, *not* 1, that the AI's `step`
   leaves exactly where it is, which is why the claim must say "positive".
-/

def Collatz (o : Nat → Nat → Nat) : Prop :=
  sorry

def lazyWorld : Nat → Nat → Nat :=
  sorry

def stuckStart : Nat :=
  sorry

end L74
