/- Hidden test battery for Level Standard instances. -/
import LeanCraftGame.Referee
import LeanCraftGame.L128.Player

open L128

#no_sorry L128.addVec
#no_sorry L128.zeroVec
#no_sorry L128.negVec
#no_sorry L128.subVec
#no_sorry L128.shiftVec
#level_start "Standard instances"

#expect_true "Vec.mk 1 2 + Vec.mk 3 4 = Vec.mk 4 6" :
  Vec.mk 1 2 + Vec.mk 3 4 = Vec.mk 4 6
#expect_true "Vec.mk 1 2 + Vec.mk 10 20 = Vec.mk 11 22" :
  Vec.mk 1 2 + Vec.mk 10 20 = Vec.mk 11 22
#expect_true "Vec.mk 0 5 + Vec.mk 7 0 = Vec.mk 7 5" :
  Vec.mk 0 5 + Vec.mk 7 0 = Vec.mk 7 5
#expect_true "(0 : Vec) = Vec.mk 0 0" :
  (0 : Vec) = Vec.mk 0 0
#expect_true "(0 : Vec) + Vec.mk 3 (-4) = Vec.mk 3 (-4)" :
  (0 : Vec) + Vec.mk 3 (-4) = Vec.mk 3 (-4)
#expect_true "-(Vec.mk 3 (-4)) = Vec.mk (-3) 4" :
  -(Vec.mk 3 (-4)) = Vec.mk (-3) 4
#expect_true "-(Vec.mk 0 5) = Vec.mk 0 (-5)" :
  -(Vec.mk 0 5) = Vec.mk 0 (-5)
#expect_true "Vec.mk 5 5 - Vec.mk 1 2 = Vec.mk 4 3" :
  Vec.mk 5 5 - Vec.mk 1 2 = Vec.mk 4 3
#expect_true "Vec.mk 1 2 - Vec.mk 5 5 = Vec.mk (-4) (-3)" :
  Vec.mk 1 2 - Vec.mk 5 5 = Vec.mk (-4) (-3)
#expect_true "Vec.mk 1 2 + (10 : ℤ) = Vec.mk 11 12" :
  Vec.mk 1 2 + (10 : ℤ) = Vec.mk 11 12
#expect_true "Vec.mk 1 2 + (-1 : ℤ) = Vec.mk 0 1" :
  Vec.mk 1 2 + (-1 : ℤ) = Vec.mk 0 1
#expect_true "Vec.mk 4 3 + (0 : ℤ) = Vec.mk 4 3" :
  Vec.mk 4 3 + (0 : ℤ) = Vec.mk 4 3
-- the instances agree with each other
#expect_true "Vec.mk 2 3 + -(Vec.mk 2 3) = 0" :
  Vec.mk 2 3 + -(Vec.mk 2 3) = 0
#expect_true "Vec.mk 2 3 - Vec.mk 2 3 = 0" :
  Vec.mk 2 3 - Vec.mk 2 3 = 0

#level_report
