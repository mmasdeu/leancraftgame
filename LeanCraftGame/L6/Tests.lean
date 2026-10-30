/- Hidden test battery for Level True or false?. -/
import LeanCraftGame.Referee
import LeanCraftGame.L6.Player

open L6

#no_sorry IsEven
#no_sorry IsSmall
#no_sorry GoesInto
#level_start "True or false?"

-- the worked example
#expect_true "IsBig 150 is true" unfolding IsBig :
  IsBig 150
#expect_false "IsBig 99 is false" unfolding IsBig :
  IsBig 99
-- your predicates
#expect_true "IsEven 10 is true" unfolding IsEven :
  IsEven 10
#expect_true "IsEven 0 is true" unfolding IsEven :
  IsEven 0
#expect_false "IsEven 7 is false" unfolding IsEven :
  IsEven 7
#expect_true "IsSmall 3 is true" unfolding IsSmall :
  IsSmall 3
#expect_true "IsSmall 9 is true" unfolding IsSmall :
  IsSmall 9
#expect_false "IsSmall 10 is false" unfolding IsSmall :
  IsSmall 10
#expect_true "GoesInto 3 12 is true" unfolding GoesInto :
  GoesInto 3 12
#expect_true "GoesInto 1 7 is true" unfolding GoesInto :
  GoesInto 1 7
#expect_false "GoesInto 5 12 is false" unfolding GoesInto :
  GoesInto 5 12

#level_report
