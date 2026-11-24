/- Hidden test battery for Level Families of sets. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L59.Player

open L59

#no_sorry UnionClosed
#no_sorry InterClosed
#no_sorry lopsided
#level_start "Families of sets"

#expect_true "The Sierpiński family {∅, {1}, {0, 1}} is closed under unions" unfolding UnionClosed :
  UnionClosed Top.sierpinski
#expect_true "The empty family is closed under unions (there is nothing to check)" unfolding UnionClosed :
  UnionClosed (∅ : Family 2)
#expect_false "{{0}, {1}} is not closed under unions: {0} ∪ {1} is missing" unfolding UnionClosed :
  UnionClosed ({{0}, {1}} : Family 2)
#expect_true "{{0}, {0, 1}} is closed under unions" unfolding UnionClosed :
  UnionClosed ({{0}, {0, 1}} : Family 3)
#expect_true "{∅, {0}, {1}} is closed under intersections" unfolding InterClosed :
  InterClosed ({∅, {0}, {1}} : Family 2)
#expect_false "{{0, 1}, {1, 2}} is not closed under intersections: {1} is missing" unfolding InterClosed :
  InterClosed ({{0, 1}, {1, 2}} : Family 3)
#expect_true "A single set is closed under intersections" unfolding InterClosed :
  InterClosed ({{2}} : Family 3)
#expect_true "Every discrete family is closed under both" unfolding UnionClosed InterClosed :
  UnionClosed (Top.discrete 3) ∧ InterClosed (Top.discrete 3)
#expect_true "lopsided is closed under intersections" unfolding lopsided :
  ∀ U ∈ lopsided, ∀ V ∈ lopsided, U ∩ V ∈ lopsided
#expect_false "lopsided is closed under unions (it must not be)" unfolding lopsided :
  ∀ U ∈ lopsided, ∀ V ∈ lopsided, U ∪ V ∈ lopsided

#level_report
