/- Hidden test battery for Level Recursion. -/
import LeanCraftGame.Referee
import LeanCraftGame.L4.Player

open L4

#no_sorry iter
#no_sorry fib
#no_sorry oddSum
#level_start "Recursion"

#expect_true "iter 0 7 = 7 (doing nothing)" unfolding iter :
  iter 0 7 = 7
#expect_true "iter 3 7 = 34 (7 → 22 → 11 → 34)" unfolding iter collatz :
  iter 3 7 = 34
#expect_true "iter 8 6 = 1" unfolding iter collatz :
  iter 8 6 = 1
#expect_true "27 reaches 1 after exactly 111 steps" unfolding iter collatz :
  iter 111 27 = 1 ∧ iter 110 27 = 2
#expect_true "fib 0 = 0, fib 1 = 1, fib 2 = 1" unfolding fib :
  fib 0 = 0 ∧ fib 1 = 1 ∧ fib 2 = 1
#expect_true "fib 10 = 55" unfolding fib :
  fib 10 = 55
#expect_true "Cassini: fib n · fib (n + 2) = fib (n + 1)² ± 1 for n < 15" unfolding fib :
  ∀ n < 15, if n % 2 = 0 then fib n * fib (n + 2) + 1 = fib (n + 1) ^ 2 else fib n * fib (n + 2) = fib (n + 1) ^ 2 + 1
#expect_true "oddSum 0 = 0 and oddSum 3 = 9" unfolding oddSum :
  oddSum 0 = 0 ∧ oddSum 3 = 9
#expect_true "oddSum n = n² for every n < 30" unfolding oddSum :
  ∀ n < 30, oddSum n = n ^ 2

#level_report
