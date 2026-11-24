/- Hidden test battery for Level And, or, not. -/
import LeanCraftGame.Referee
import LeanCraftGame.L8.Player

open L8

#no_sorry IsSophieGermain
#no_sorry IsTwinPrime
#no_sorry IsComposite
#no_sorry ExactlyOneOf23
#level_start "And, or, not"

#expect_true "11 is a Sophie Germain prime (23 is prime)" unfolding IsSophieGermain :
  IsSophieGermain 11
#expect_false "7 is not a Sophie Germain prime (15 is not prime)" unfolding IsSophieGermain :
  IsSophieGermain 7
#expect_false "9 is not a Sophie Germain prime (19 is prime, but 9 is not)" unfolding IsSophieGermain :
  IsSophieGermain 9
#expect_true "17 and 19 are twin primes" unfolding IsTwinPrime :
  IsTwinPrime 17
#expect_false "7 and 9 are not twin primes" unfolding IsTwinPrime :
  IsTwinPrime 7
#expect_true "15 is composite" unfolding IsComposite :
  IsComposite 15
#expect_false "13 is not composite" unfolding IsComposite :
  IsComposite 13
#expect_false "1 is not composite" unfolding IsComposite :
  IsComposite 1
#expect_false "0 is not composite (by this definition)" unfolding IsComposite :
  IsComposite 0
#expect_true "ExactlyOneOf23 4 (divisible by 2 only)" unfolding ExactlyOneOf23 :
  ExactlyOneOf23 4
#expect_true "ExactlyOneOf23 9 (divisible by 3 only)" unfolding ExactlyOneOf23 :
  ExactlyOneOf23 9
#expect_false "ExactlyOneOf23 12 (divisible by both)" unfolding ExactlyOneOf23 :
  ExactlyOneOf23 12
#expect_false "ExactlyOneOf23 7 (divisible by neither)" unfolding ExactlyOneOf23 :
  ExactlyOneOf23 7

#level_report
