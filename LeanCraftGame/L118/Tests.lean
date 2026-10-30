/- Hidden test battery for Level Filters and counting. -/
import LeanCraftGame.Referee
import LeanCraftGame.L118.Player

open L118

#no_sorry numDivisors
#no_sorry countPrimes
#no_sorry fact
#no_sorry multiples3or5
#no_sorry IsPerfect
#level_start "Filters and counting"

-- the worked examples
#expect_true "(evenSet 7).card = 4 (the worked example)" unfolding evenSet :
  (evenSet 7).card = 4
#expect_true "sumOdds 6 = 9 (the worked example)" unfolding sumOdds :
  sumOdds 6 = 9
-- your definitions
#expect_true "numDivisors 12 = 6" unfolding numDivisors :
  numDivisors 12 = 6
#expect_true "numDivisors 13 = 2 (a prime has two divisors)" unfolding numDivisors :
  numDivisors 13 = 2
#expect_true "numDivisors 1 = 1" unfolding numDivisors :
  numDivisors 1 = 1
#expect_true "numDivisors 0 = 0 (0 has no positive divisor)" unfolding numDivisors :
  numDivisors 0 = 0
#expect_true "countPrimes 10 = 4" unfolding countPrimes :
  countPrimes 10 = 4
#expect_true "countPrimes 11 = 4 (11 itself is not below 11)" unfolding countPrimes :
  countPrimes 11 = 4
#expect_true "countPrimes 12 = 5" unfolding countPrimes :
  countPrimes 12 = 5
#expect_true "countPrimes 2 = 0 (0 and 1 are not prime)" unfolding countPrimes :
  countPrimes 2 = 0
#expect_true "fact 0 = 1 (the empty product)" unfolding fact :
  fact 0 = 1
#expect_true "fact 1 = 1" unfolding fact :
  fact 1 = 1
#expect_true "fact 4 = 24" unfolding fact :
  fact 4 = 24
#expect_true "fact 6 = 720" unfolding fact :
  fact 6 = 720
#expect_true "multiples3or5 10 = 23" unfolding multiples3or5 :
  multiples3or5 10 = 23
#expect_true "multiples3or5 0 = 0" unfolding multiples3or5 :
  multiples3or5 0 = 0
#expect_true "multiples3or5 5 = 3 (5 itself is not below 5)" unfolding multiples3or5 :
  multiples3or5 5 = 3
#expect_true "multiples3or5 16 = 60 (15 counts once)" unfolding multiples3or5 :
  multiples3or5 16 = 60
#expect_true "IsPerfect 6 is true" unfolding IsPerfect :
  IsPerfect 6
#expect_true "IsPerfect 28 is true" unfolding IsPerfect :
  IsPerfect 28
#expect_false "IsPerfect 12 is false" unfolding IsPerfect :
  IsPerfect 12
#expect_false "IsPerfect 0 is false (the empty sum is 0, but 0 is not positive)" unfolding IsPerfect :
  IsPerfect 0
#expect_false "IsPerfect 1 is false" unfolding IsPerfect :
  IsPerfect 1
#expect_false "IsPerfect 8 is false" unfolding IsPerfect :
  IsPerfect 8

#level_report
