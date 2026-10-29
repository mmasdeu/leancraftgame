/- Hidden test battery for Level 3. -/
import LeanCraftGame.Referee
import LeanCraftGame.L3.Player

open L3

#no_sorry GoldbachFor
#level_start "Level 3 · The AI proved Goldbach!"

-- Toy worlds where the answer is known
#expect_true "World 1: every number is 'prime' (Goldbach is trivially TRUE)" unfolding GoldbachFor :
  GoldbachFor (fun _ => True)
#expect_true "World 2: the 'primes' are the odd numbers (TRUE: n = 1 + (n-1))" unfolding GoldbachFor :
  GoldbachFor (fun p => p % 2 = 1)
#expect_true "World 3: the 'primes' are the numbers ≥ 2 (TRUE: n = 2 + (n-2))" unfolding GoldbachFor :
  GoldbachFor (fun p => 2 ≤ p)
#expect_false "World 4: no number is 'prime' (Goldbach is FALSE)" unfolding GoldbachFor :
  GoldbachFor (fun _ => False)
#expect_false "World 5: the only 'prime' is 2 (FALSE: 6 ≠ 2 + 2)" unfolding GoldbachFor :
  GoldbachFor (fun p => p = 2)

-- The real world
#expect_open "The real world: Goldbach's conjecture itself" unfolding GoldbachFor IsPrime :
  GoldbachFor IsPrime

#level_report
