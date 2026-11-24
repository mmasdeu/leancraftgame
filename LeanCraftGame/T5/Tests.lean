/- Hidden test battery for T5 Standard examples. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Basic
import LeanCraftGame.T5.Player

open LeanCraftGame.Topology

#no_sorry T5.sierpinskiSpace
#level_start "Standard examples: Sierpiński space"

#expect_true "the universal set is open" :
  T5.sierpinskiSpace.IsOpen Set.univ

#expect_true "the empty set is open" :
  T5.sierpinskiSpace.IsOpen ∅

#expect_true "the singleton true is open" unfolding T5.sierpinskiSpace particularPoint :
  T5.sierpinskiSpace.IsOpen {true}

#expect_false "the singleton false is not open" unfolding T5.sierpinskiSpace particularPoint :
  T5.sierpinskiSpace.IsOpen {false}

#level_report
