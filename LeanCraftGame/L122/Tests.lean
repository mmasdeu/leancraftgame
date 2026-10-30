/- Hidden test battery for Level Declaring a structure. -/
import LeanCraftGame.Referee
import LeanCraftGame.L122.Player

open L122

#no_sorry origin
#no_sorry p34
#no_sorry wide
#no_sorry queenOfHearts
#no_sorry perimeter
#no_sorry swapPoint
#level_start "Declaring a structure"

-- the worked example
#expect_true "(Point.mk 3 4).y = 4" :
  (Point.mk 3 4).y = 4
-- the fields, in the order they are declared
#expect_true "the first field of a Rectangle is its width" :
  (Rectangle.mk 7 2).width = 7
#expect_true "the second field of a Rectangle is its height" :
  (Rectangle.mk 7 2).height = 2
#expect_true "the first field of a Card is its rank" :
  (Card.mk 12 2).rank = 12
#expect_true "the second field of a Card is its suit" :
  (Card.mk 12 2).suit = 2
-- the values
#expect_true "origin has x = 0" :
  origin.x = 0
#expect_true "origin has y = 0" :
  origin.y = 0
#expect_true "p34 has x = 3" :
  p34.x = 3
#expect_true "p34 has y = 4" :
  p34.y = 4
#expect_true "wide has width 7" :
  wide.width = 7
#expect_true "wide has height 2" :
  wide.height = 2
#expect_true "queenOfHearts has rank 12" :
  queenOfHearts.rank = 12
#expect_true "queenOfHearts has suit 2" :
  queenOfHearts.suit = 2
-- the functions
#expect_true "perimeter of a 7 by 2 rectangle is 18" :
  perimeter ⟨7, 2⟩ = 18
#expect_true "perimeter of a 3 by 5 rectangle is 16" :
  perimeter ⟨3, 5⟩ = 16
#expect_true "perimeter of a 0 by 5 rectangle is 10" :
  perimeter ⟨0, 5⟩ = 10
#expect_true "swapPoint ⟨3, 4⟩ has x = 4" :
  (swapPoint ⟨3, 4⟩).x = 4
#expect_true "swapPoint ⟨3, 4⟩ has y = 3" :
  (swapPoint ⟨3, 4⟩).y = 3
#expect_true "swapPoint ⟨0, 9⟩ has x = 9" :
  (swapPoint ⟨0, 9⟩).x = 9

#level_report
