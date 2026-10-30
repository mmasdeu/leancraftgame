/- Hidden test battery for Level Sets. -/
import LeanCraftGame.Referee
import LeanCraftGame.L19.Player

open L19

#no_sorry multiplesOf
#no_sorry BoundedSet
#level_start "Sets"

-- the worked example
#expect_true "4 ∈ evens is true" unfolding evens :
  4 ∈ evens
#expect_false "3 ∈ evens is false" unfolding evens :
  3 ∈ evens
-- your definitions
#expect_true "12 ∈ multiplesOf 3 is true" unfolding multiplesOf :
  12 ∈ multiplesOf 3
#expect_false "13 ∈ multiplesOf 3 is false" unfolding multiplesOf :
  13 ∈ multiplesOf 3
#expect_true "0 ∈ multiplesOf 5 is true" unfolding multiplesOf :
  0 ∈ multiplesOf 5
#expect_true "multiplesOf 4 ⊆ evens is true" unfolding multiplesOf evens :
  multiplesOf 4 ⊆ evens
#expect_false "evens ⊆ multiplesOf 4 is false" unfolding multiplesOf evens :
  evens ⊆ multiplesOf 4
#expect_true "BoundedSet {n | n < 10} is true" unfolding BoundedSet :
  BoundedSet {n | n < 10}
#expect_true "BoundedSet ∅ is true" unfolding BoundedSet :
  BoundedSet ∅
#expect_false "BoundedSet {n | 5 ≤ n} is false (5, 6, 7, … has no upper bound)" unfolding BoundedSet :
  BoundedSet {n | 5 ≤ n}

#level_report
