/- Hidden test battery for Level Challenge: classes. -/
import LeanCraftGame.Referee
import LeanCraftGame.L130.Player

open L130

#no_sorry L130.Score.value
#no_sorry L130.ordScore
#no_sorry L130.maxScore
#no_sorry L130.minScore
#no_sorry L130.best
#level_start "Challenge: classes"

-- value
#expect_true "Score.value (Score.mk 7 2) = 5" unfolding Score.value :
  Score.value (Score.mk 7 2) = 5
#expect_true "Score.value (Score.mk 3 5) = -2" unfolding Score.value :
  Score.value (Score.mk 3 5) = -2
-- compare
#expect_true "compare (Score.mk 5 0) (Score.mk 2 0) = .gt" :
  compare (Score.mk 5 0) (Score.mk 2 0) = Ordering.gt
#expect_true "compare (Score.mk 2 0) (Score.mk 5 0) = .lt" :
  compare (Score.mk 2 0) (Score.mk 5 0) = Ordering.lt
#expect_true "compare (Score.mk 9 8) (Score.mk 2 0) = .lt (value 1 against 2)" :
  compare (Score.mk 9 8) (Score.mk 2 0) = Ordering.lt
#expect_true "compare (Score.mk 1 5) (Score.mk 0 0) = .lt (value -4 against 0)" :
  compare (Score.mk 1 5) (Score.mk 0 0) = Ordering.lt
#expect_true "compare (Score.mk 5 1) (Score.mk 4 0) = .gt (equal values, more points)" :
  compare (Score.mk 5 1) (Score.mk 4 0) = Ordering.gt
#expect_true "compare (Score.mk 4 0) (Score.mk 5 1) = .lt (equal values, fewer points)" :
  compare (Score.mk 4 0) (Score.mk 5 1) = Ordering.lt
#expect_true "compare (Score.mk 3 1) (Score.mk 3 1) = .eq" :
  compare (Score.mk 3 1) (Score.mk 3 1) = Ordering.eq
-- max and min
#expect_true "max (Score.mk 5 0) (Score.mk 2 0) = Score.mk 5 0" :
  max (Score.mk 5 0) (Score.mk 2 0) = Score.mk 5 0
#expect_true "max (Score.mk 2 0) (Score.mk 9 8) = Score.mk 2 0 (value 2 beats value 1)" :
  max (Score.mk 2 0) (Score.mk 9 8) = Score.mk 2 0
#expect_true "max (Score.mk 5 1) (Score.mk 4 0) = Score.mk 5 1 (equal values)" :
  max (Score.mk 5 1) (Score.mk 4 0) = Score.mk 5 1
#expect_true "max (Score.mk 4 0) (Score.mk 5 1) = Score.mk 5 1 (equal values, other order)" :
  max (Score.mk 4 0) (Score.mk 5 1) = Score.mk 5 1
#expect_true "max (Score.mk 3 1) (Score.mk 3 1) = Score.mk 3 1" :
  max (Score.mk 3 1) (Score.mk 3 1) = Score.mk 3 1
#expect_true "min (Score.mk 5 0) (Score.mk 2 0) = Score.mk 2 0" :
  min (Score.mk 5 0) (Score.mk 2 0) = Score.mk 2 0
#expect_true "min (Score.mk 2 0) (Score.mk 9 8) = Score.mk 9 8 (value 1 is below value 2)" :
  min (Score.mk 2 0) (Score.mk 9 8) = Score.mk 9 8
#expect_true "min (Score.mk 5 1) (Score.mk 4 0) = Score.mk 4 0 (equal values)" :
  min (Score.mk 5 1) (Score.mk 4 0) = Score.mk 4 0
#expect_true "min (Score.mk 4 0) (Score.mk 5 1) = Score.mk 4 0 (equal values, other order)" :
  min (Score.mk 4 0) (Score.mk 5 1) = Score.mk 4 0
-- best
#expect_true "best [] = Score.mk 0 0" unfolding best :
  best [] = Score.mk 0 0
#expect_true "best [Score.mk 0 3] = Score.mk 0 3 (a lone negative score)" unfolding best :
  best [Score.mk 0 3] = Score.mk 0 3
#expect_true "best [Score.mk 2 0, Score.mk 9 8, Score.mk 4 3] = Score.mk 2 0" unfolding best :
  best [Score.mk 2 0, Score.mk 9 8, Score.mk 4 3] = Score.mk 2 0
#expect_true "best [Score.mk 4 3, Score.mk 5 4] = Score.mk 5 4 (equal values)" unfolding best :
  best [Score.mk 4 3, Score.mk 5 4] = Score.mk 5 4
#expect_true "best [Score.mk 1 4, Score.mk 0 5, Score.mk 0 9] = Score.mk 1 4" unfolding best :
  best [Score.mk 1 4, Score.mk 0 5, Score.mk 0 9] = Score.mk 1 4

#level_report
