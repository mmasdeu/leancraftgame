/- Hidden test battery for Level Recursion. -/
import DefGame.Referee
import DefGame.L15.Player

open L15

#no_sorry sumTo
#no_sorry pow2
#no_sorry fib
#level_start "Recursion"

-- the worked example
#expect_true "factorial 5 = 120" :
  factorial 5 = 120
-- your functions
#expect_true "sumTo 0 = 0" :
  sumTo 0 = 0
#expect_true "sumTo 4 = 10" :
  sumTo 4 = 10
#expect_true "sumTo 100 = 5050" :
  sumTo 100 = 5050
#expect_true "pow2 0 = 1" :
  pow2 0 = 1
#expect_true "pow2 3 = 8" :
  pow2 3 = 8
#expect_true "pow2 10 = 1024" :
  pow2 10 = 1024
#expect_true "fib 0 = 0" :
  fib 0 = 0
#expect_true "fib 1 = 1" :
  fib 1 = 1
#expect_true "fib 2 = 1" :
  fib 2 = 1
#expect_true "fib 10 = 55" :
  fib 10 = 55

#level_report
