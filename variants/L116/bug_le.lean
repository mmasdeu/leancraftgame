/-
# The AI proved the Collatz conjecture!

An AI assistant was asked to formalise and prove the Collatz conjecture:

  "Start from any positive number. If it is even, halve it; if it is
   odd, multiply it by 3 and add 1. Repeat. You always reach 1."

It came back with the code below. Everything compiles, there is no
`sorry`, and the proof is one line long. An open problem with a one-line
proof is a smell, but *where* exactly does it smell?

## Auditing, round two

The checklist from "The AI proved the infinitude of primes!" still
applies. These items matter most here:

1. **Cheapest witness.** In `∃ k, …`, what happens at `k = 0`, the
   laziest choice? A statement that a do-nothing step already satisfies
   says nothing.
2. **Compare the relation, not just the shape.** `=`, `≤` and `<` look alike
   and are not alike. Replace the relation by a silly one and see who
   still agrees.
3. **Junk values.** Lean never says "undefined": `0 - 5 = 0`,
   `7 / 0 = 0`. Ask which input makes the *real* process get stuck on
   such a value, and whether the claim has to exclude it.
4. **Side conditions.** Is each hypothesis of the claim ("positive",
   "even", ...) still there in the formula? Which input would break
   the formula if the hypothesis were dropped?
5. **Toy worlds.** The claim speaks about one particular process. Let
   `o n k` be the number you are at after `k` steps starting from `n`
   (`o n 0 = n`), and let the process be *anything*: counting up,
   counting down, jumping to 0. A faithful statement must be right in
   all of them. (`Collatz o` below means: from every positive start
   the process reaches exactly 1.)
-/
namespace L116

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
  ∀ n, 0 < n → ∃ k, o n k ≤ n

def lazyWorld : Nat → Nat → Nat :=
  fun n k => n + k

def stuckStart : Nat :=
  0
