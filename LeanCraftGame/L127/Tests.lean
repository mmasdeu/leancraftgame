/- Hidden test battery for Level Classes and instances. -/
import LeanCraftGame.Referee
import LeanCraftGame.L127.Player

open L127

#no_sorry L127.sizeString
#no_sorry L127.sizeList
#no_sorry L127.sizeRect
#level_start "Classes and instances"

-- the worked example
#expect_true "Size.size (7 : ℕ) = 7" :
  Size.size (7 : ℕ) = 7
-- strings
#expect_true "Size.size \"abc\" = 3" :
  Size.size "abc" = 3
#expect_true "Size.size \"\" = 0" :
  Size.size "" = 0
-- lists: the number of entries, not their sum
#expect_true "Size.size [10, 20] = 2" :
  Size.size [10, 20] = 2
#expect_true "Size.size [7] = 1" :
  Size.size [7] = 1
#expect_true "Size.size ([] : List ℕ) = 0" :
  Size.size ([] : List ℕ) = 0
-- rectangles: area, not perimeter or sum
#expect_true "Size.size (Rect.mk 3 4) = 12" :
  Size.size (Rect.mk 3 4) = 12
#expect_true "Size.size (Rect.mk 0 5) = 0" :
  Size.size (Rect.mk 0 5) = 0
#expect_true "Size.size (Rect.mk 1 1) = 1" :
  Size.size (Rect.mk 1 1) = 1
-- the function from the worked example uses your instances
#expect_true "bigger [1, 2, 3] [100] holds" unfolding bigger :
  bigger [1, 2, 3] [100]
#expect_false "bigger (Rect.mk 1 9) (Rect.mk 3 3) holds" unfolding bigger :
  bigger (Rect.mk 1 9) (Rect.mk 3 3)
#expect_true "bigger \"hello\" \"abc\" holds" unfolding bigger :
  bigger "hello" "abc"

#level_report
