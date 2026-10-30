/- Hidden test battery for Level Instances that depend on instances. -/
import LeanCraftGame.Referee
import LeanCraftGame.L129.Player

open L129

#no_sorry L129.addPair
#no_sorry L129.sizePair
#no_sorry L129.sizeList
#no_sorry L129.largest
#no_sorry L129.heavy
#level_start "Instances that depend on instances"

-- Add (Pair α), at three types, one nested
#expect_true "Pair.mk (1 : ℕ) 2 + Pair.mk 3 4 = Pair.mk 4 6" :
  Pair.mk (1 : ℕ) 2 + Pair.mk 3 4 = Pair.mk 4 6
#expect_true "Pair.mk (5 : ℤ) (-2) + Pair.mk (-5) 2 = Pair.mk 0 0" :
  Pair.mk (5 : ℤ) (-2) + Pair.mk (-5) 2 = Pair.mk 0 0
#expect_true "Pair.mk (0 : ℕ) 7 + Pair.mk 9 0 = Pair.mk 9 7" :
  Pair.mk (0 : ℕ) 7 + Pair.mk 9 0 = Pair.mk 9 7
#expect_true "Pair (Pair ℕ): coordinatewise at both levels" :
  Pair.mk (Pair.mk (1 : ℕ) 2) (Pair.mk 3 4) + Pair.mk (Pair.mk 10 20) (Pair.mk 30 40)
    = Pair.mk (Pair.mk 11 22) (Pair.mk 33 44)
#expect_true "Pair (ℕ × ℕ): the pairs of `Prod` add too" :
  Pair.mk ((1 : ℕ), (2 : ℕ)) ((3 : ℕ), (4 : ℕ)) + Pair.mk (10, 20) (30, 40)
    = Pair.mk (11, 22) (33, 44)
-- Size (Pair α)
#expect_true "Size.size (Pair.mk \"ab\" \"cde\") = 5" :
  Size.size (Pair.mk "ab" "cde") = 5
#expect_true "Size.size (Pair.mk (0 : ℕ) 8) = 8" :
  Size.size (Pair.mk (0 : ℕ) 8) = 8
#expect_true "Size.size (Pair.mk (Pair.mk (1 : ℕ) 2) (Pair.mk 3 4)) = 10" :
  Size.size (Pair.mk (Pair.mk (1 : ℕ) 2) (Pair.mk 3 4)) = 10
-- Size (List α)
#expect_true "Size.size [\"ab\", \"c\"] = 3" :
  Size.size ["ab", "c"] = 3
#expect_true "Size.size [10, 20] = 30" :
  Size.size [(10 : ℕ), 20] = 30
#expect_true "Size.size ([] : List String) = 0" :
  Size.size ([] : List String) = 0
#expect_true "Size.size [[1, 2], [3]] = 6" :
  Size.size [[(1 : ℕ), 2], [3]] = 6
#expect_true "Size.size [Pair.mk 1 2, Pair.mk 3 4] = 10" :
  Size.size [Pair.mk (1 : ℕ) 2, Pair.mk 3 4] = 10
-- largest
#expect_true "largest [\"ab\", \"abcd\", \"c\"] = 4" unfolding largest :
  largest ["ab", "abcd", "c"] = 4
#expect_true "largest [3, 9, 2] = 9" unfolding largest :
  largest [(3 : ℕ), 9, 2] = 9
#expect_true "largest [Pair.mk \"a\" \"bc\", Pair.mk \"\" \"\"] = 3" unfolding largest :
  largest [Pair.mk "a" "bc", Pair.mk "" ""] = 3
#expect_true "largest ([] : List ℕ) = 0" unfolding largest :
  largest ([] : List ℕ) = 0
#expect_true "largest [[5, 5], [1]] = 10" unfolding largest :
  largest [[(5 : ℕ), 5], [1]] = 10
-- heavy
#expect_true "heavy (5 : ℕ) = 15" unfolding heavy :
  heavy (5 : ℕ) = 15
#expect_true "heavy \"ab\" = 12" unfolding heavy :
  heavy "ab" = 12

#level_report
