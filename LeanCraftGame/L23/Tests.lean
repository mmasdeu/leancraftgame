/- Hidden test battery for Level 23: Infinitely many primes. -/
import LeanCraftGame.Referee
import LeanCraftGame.L23.Player

open L23

namespace L23Ref
def Real (P : ℕ → Prop) : Prop := ∀ n, ∃ p, n < p ∧ P p
end L23Ref

#no_sorry Unbounded
#no_sorry smallWorld
#no_sorry fakePrime
#no_sorry L23.euclid
#no_sorry L23.euclid_mod4
#no_sorry q1
#no_sorry q2
#level_start "Infinitely many primes"

#expect_true "Toy world: every number is 'prime'" unfolding Unbounded : Unbounded (fun _ => True)
#expect_false "Toy world: nothing is 'prime'" unfolding Unbounded : Unbounded (fun _ => False)
#expect_false "Toy world: the 'primes' are 2 and 3" unfolding Unbounded : Unbounded (fun p => p = 2 ∨ p = 3)
#expect_true "Toy world: the 'primes' are the odd numbers" unfolding Unbounded : Unbounded (fun p => p % 2 = 1)
#expect_true "Your world: nothing outside [2, 100]" unfolding smallWorld :
  ∀ p, smallWorld p → 2 ≤ p ∧ p ≤ 100
#expect_true "Your world: the Prover's claim holds there" unfolding AIClaim smallWorld : AIClaim smallWorld
#expect_false "Your world: infinitely many 'primes' there" unfolding L23Ref.Real smallWorld :
  L23Ref.Real smallWorld
#expect_true "Your fakePrime: the Prover's IsPrime accepts it" unfolding IsPrime fakePrime : IsPrime fakePrime
#expect_false "Your fakePrime: it is a real prime" unfolding fakePrime : Nat.Prime fakePrime
#expect_equiv "euclid says: for every n, a prime p ≥ n" :
  L23.euclid ↔ ∀ n : ℕ, ∃ p, n ≤ p ∧ Nat.Prime p
  using Nat.exists_infinite_primes
#expect_equiv "euclid_mod4 says: for every n, a prime p ≥ n with p % 4 = 3" :
  L23.euclid_mod4 ↔ ∀ n : ℕ, ∃ p, n ≤ p ∧ Nat.Prime p ∧ p % 4 = 3
#expect_choice "Question 1: why Lean accepts the recursion of `digitSum`" : q1 = 1
#expect_choice "Question 2: `digitSum 1234 = 10`?" : q2 = true

#level_report
