/- Hidden test battery for Level Challenge: finite sums. -/
import LeanCraftGame.Referee
import LeanCraftGame.L120.Player

open L120

#no_sorry telescope
#no_sorry sumPlusOne
#no_sorry rangeSum
#no_sorry totalChange
#no_sorry floorSum
#level_start "Challenge: finite sums"

#expect_true "telescope 0 = 0 (the empty sum)" unfolding telescope :
  telescope 0 = 0
#expect_true "telescope 1 = 1/2" unfolding telescope :
  telescope 1 = 1 / 2
#expect_true "telescope 2 = 2/3" unfolding telescope :
  telescope 2 = 2 / 3
#expect_true "telescope 9 = 9/10" unfolding telescope :
  telescope 9 = 9 / 10
#expect_true "sumPlusOne 0 = 1 (the empty sum, plus one)" unfolding sumPlusOne :
  sumPlusOne 0 = 1
#expect_true "sumPlusOne 1 = 1" unfolding sumPlusOne :
  sumPlusOne 1 = 1
#expect_true "sumPlusOne 4 = 7" unfolding sumPlusOne :
  sumPlusOne 4 = 7
#expect_true "rangeSum 3 5 = 12" unfolding rangeSum :
  rangeSum 3 5 = 12
#expect_true "rangeSum 4 4 = 4 (a single term)" unfolding rangeSum :
  rangeSum 4 4 = 4
#expect_true "rangeSum 0 4 = 10" unfolding rangeSum :
  rangeSum 0 4 = 10
#expect_true "rangeSum 5 3 = 0 (b < a: nothing to add)" unfolding rangeSum :
  rangeSum 5 3 = 0
#expect_true "rangeSum 1 0 = 0 (b < a with b = 0)" unfolding rangeSum :
  rangeSum 1 0 = 0
#expect_true "totalChange (fun i => i % 3) 6 = 8" unfolding totalChange :
  totalChange (fun i => i % 3) 6 = 8
#expect_true "totalChange (fun i => i) 5 = 5 (going up)" unfolding totalChange :
  totalChange (fun i => i) 5 = 5
#expect_true "totalChange (fun i => 10 - i) 4 = 4 (going down)" unfolding totalChange :
  totalChange (fun i => 10 - i) 4 = 4
#expect_true "totalChange (fun _ => 7) 9 = 0 (constant)" unfolding totalChange :
  totalChange (fun _ => 7) 9 = 0
#expect_true "totalChange (fun i => i % 3) 0 = 0 (no steps)" unfolding totalChange :
  totalChange (fun i => i % 3) 0 = 0
#expect_true "floorSum 0 = 0" unfolding floorSum :
  floorSum 0 = 0
#expect_true "floorSum 1 = 1" unfolding floorSum :
  floorSum 1 = 1
#expect_true "floorSum 4 = 8" unfolding floorSum :
  floorSum 4 = 8
#expect_true "floorSum 6 = 14 (6 + 3 + 2 + 1 + 1 + 1)" unfolding floorSum :
  floorSum 6 = 14

#level_report
