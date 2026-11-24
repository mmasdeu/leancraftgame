/- Hidden test battery for T1 Sets and operations. -/
import LeanCraftGame.Referee
import LeanCraftGame.T1.Player

open T1

#no_sorry MyDisjoint
#level_start "Sets and operations"

#expect_true "disjoint means no common element" unfolding MyDisjoint :
  ∀ {α : Type*} (s t : Set α), MyDisjoint s t → ∀ x, x ∈ s → x ∈ t → False

#expect_true "no common element implies disjoint" unfolding MyDisjoint :
  ∀ {α : Type*} (s t : Set α), (∀ x, x ∈ s → x ∈ t → False) → MyDisjoint s t

#expect_true "unequal singletons are disjoint" unfolding MyDisjoint :
  MyDisjoint ({0} : Set Nat) {1}

#expect_false "a singleton overlaps itself" unfolding MyDisjoint :
  MyDisjoint ({0} : Set Nat) {0}

#level_report
