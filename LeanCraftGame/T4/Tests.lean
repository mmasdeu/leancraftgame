/- Hidden test battery for T4 The definition of a topology. -/
import LeanCraftGame.Referee
import LeanCraftGame.T4.Player

#no_sorry T4.MyTopology
#level_start "The definition of a topology"

#expect_model "discrete topology is accepted" :
  T4.MyTopology.mk (fun _ : Set Nat => True)

#expect_not_model "candidate with only the empty set is rejected" :
  T4.MyTopology.mk (fun s : Set Bool => s = ∅)

#expect_not_model "the empty family of opens is rejected" :
  T4.MyTopology.mk (fun _ : Set Bool => False)

#level_report
