/- Hidden test battery for Level 116. -/
import LeanCraftGame.Referee
import LeanCraftGame.L116.Player

open L116

namespace L116Ref
def Collatz (o : Nat → Nat → Nat) : Prop := ∀ n, 0 < n → ∃ k, o n k = 1
end L116Ref

#no_sorry Collatz
#no_sorry lazyWorld
#no_sorry stuckStart
#level_start "Level 116 · The AI proved the Collatz conjecture!"

-- Toy processes where the answer is known
#expect_true "Process 1: counting down, n - k (TRUE: k = n - 1 lands on 1; but 0 never does, so n = 0 must be excluded)" unfolding Collatz :
  Collatz (fun n k => n - k)
#expect_false "Process 2: counting up, n + k (FALSE: from 2 it never returns to 1, though the AI's claim holds with k = 0)" unfolding Collatz :
  Collatz (fun n k => n + k)
#expect_false "Process 3: everything jumps to 0 after the start (FALSE: 0 is not 1, even though 0 ≤ 1)" unfolding Collatz :
  Collatz (fun n k => if k = 0 then n else 0)
#expect_false "Process 4: counting down by 2 (FALSE: 2, 0, 0, … skips 1 and sticks at 0)" unfolding Collatz :
  Collatz (fun n k => n - 2 * k)
#expect_true "Process 5: stays at n until step n, then 1 (TRUE: but k must depend on n)" unfolding Collatz :
  Collatz (fun n k => if k < n then n else 1)
#expect_false "Process 6: nothing ever moves (FALSE, the AI's claim holds with k = 0)" unfolding Collatz :
  Collatz (fun n _ => n)

-- Your lazy process
#expect_true "Your lazyWorld is a process: it starts at n (lazyWorld n 0 = n)" unfolding lazyWorld :
  ∀ n, lazyWorld n 0 = n
#expect_true "Your lazyWorld: the AI's claim holds there" unfolding AIClaim lazyWorld :
  AIClaim lazyWorld
#expect_false "Your lazyWorld: the real claim (every positive start reaches 1) must FAIL there" unfolding L116Ref.Collatz lazyWorld :
  L116Ref.Collatz lazyWorld

-- Your stuck start
#expect_true "Your stuckStart: the AI's step leaves it where it is" unfolding step stuckStart :
  step stuckStart = stuckStart
#expect_true "Your stuckStart is not 1" unfolding stuckStart :
  stuckStart ≠ 1

-- The real conjecture
#expect_open "The real world: the Collatz conjecture itself" unfolding Collatz orbit step :
  Collatz orbit

#level_report
