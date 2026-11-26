/- Hidden test battery for Level 51: Final audit. -/
import LeanCraftGame.Referee
import LeanCraftGame.L51.Player

open L51

#no_sorry GoldbachFor
#no_sorry CollatzFor
#no_sorry q1
#no_sorry q2
#no_sorry q3
#level_start "Final audit: the AI proved Goldbach!"

-- Goldbach in toy worlds
#expect_true "Goldbach, world A: the 'primes' are the even numbers" unfolding GoldbachFor :
  GoldbachFor (fun p => p % 2 = 0)
#expect_true "Goldbach, world B: the 'primes' are the numbers ≥ 2" unfolding GoldbachFor :
  GoldbachFor (fun p => 2 ≤ p)
#expect_false "Goldbach, world C: no number is 'prime'" unfolding GoldbachFor :
  GoldbachFor (fun _ => False)
#expect_open "Goldbach in the real world" unfolding GoldbachFor :
  GoldbachFor Nat.Prime

-- Collatz in toy processes
#expect_true "Collatz, process A: counting down, n - k" unfolding CollatzFor :
  CollatzFor (fun n k => n - k)
#expect_false "Collatz, process B: everything falls to 0 after the start" unfolding CollatzFor :
  CollatzFor (fun n k => if k = 0 then n else 0)
#expect_true "Collatz, process C: stays at n until step n, then jumps to 1" unfolding CollatzFor :
  CollatzFor (fun n k => if k < n then n else 1)
#expect_open "Collatz in the real world" unfolding CollatzFor collatz :
  CollatzFor (fun n k => collatz^[k] n)

-- Three more audits
#expect_choice "Audit 1: infinitely many primes" : q1 = false
#expect_choice "Audit 2: convergent sequences are bounded" : q2 = true
#expect_choice "Audit 3: |x| has no derivative at 0" : q3 = false

#level_report
