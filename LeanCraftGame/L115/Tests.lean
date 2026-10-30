/- Hidden test battery for Level 115. -/
import LeanCraftGame.Referee
import LeanCraftGame.L115.Player

open L115

namespace L115Ref
def Real (P : Nat → Prop) : Prop := ∀ n, ∃ p, n < p ∧ P p
end L115Ref

#no_sorry Unbounded
#no_sorry smallWorld
#no_sorry fakePrime
#level_start "Level 115 · The AI proved the infinitude of primes!"

-- Toy worlds where the answer is known
#expect_true "Toy world 1: every number is 'prime' (infinitely many: TRUE)" unfolding Unbounded :
  Unbounded (fun _ => True)
#expect_true "Toy world 2: the 'primes' are the odd numbers (infinitely many: TRUE)" unfolding Unbounded :
  Unbounded (fun p => p % 2 = 1)
#expect_true "Toy world 3: the 'primes' are the numbers ≥ 2 (infinitely many: TRUE)" unfolding Unbounded :
  Unbounded (fun p => 2 ≤ p)
#expect_false "Toy world 4: no number is 'prime' (FALSE)" unfolding Unbounded :
  Unbounded (fun _ => False)
#expect_false "Toy world 5: the only 'prime' is 2 (FALSE)" unfolding Unbounded :
  Unbounded (fun p => p = 2)
#expect_false "Toy world 6: the 'primes' are 2 and 3 (FALSE: only two of them, though the AI's claim holds)" unfolding Unbounded :
  Unbounded (fun p => p = 2 ∨ p = 3)
#expect_false "Toy world 7: the 'primes' are the numbers up to 100 (FALSE: finitely many)" unfolding Unbounded :
  Unbounded (fun p => p ≤ 100)

-- Your counterexample world
#expect_true "Your world: contains only numbers ≥ 2" unfolding smallWorld :
  ∀ p, smallWorld p → 2 ≤ p
#expect_true "Your world: contains nothing above 100" unfolding smallWorld :
  ∀ p, smallWorld p → p ≤ 100
#expect_true "Your world: the AI's claim holds there (for every n there is a 'prime' other than n; your world needs at least two numbers)" unfolding AIClaim smallWorld :
  AIClaim smallWorld
#expect_false "Your world: there should NOT be infinitely many 'primes' there (the real claim must fail)" unfolding L115Ref.Real smallWorld :
  L115Ref.Real smallWorld

-- Your fake prime
#expect_true "Your fakePrime: the AI's IsPrime accepts it" unfolding IsPrime fakePrime :
  IsPrime fakePrime
#expect_false "Your fakePrime: it must not be a real prime" unfolding fakePrime :
  Nat.Prime fakePrime

#level_report
