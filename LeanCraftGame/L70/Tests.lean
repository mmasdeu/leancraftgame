/- Hidden test battery for Level Connectedness. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L70.Player

open Top

#no_sorry L70.IsClopen
#no_sorry L70.IsConnected
#no_sorry L70.split
#level_start "Connectedness"

#expect_true "In the discrete space, {0} is clopen" unfolding L70.IsClopen :
  L70.IsClopen (discrete 3) {0}
#expect_false "In Sierpiński space, {1} is clopen" unfolding L70.IsClopen :
  L70.IsClopen sierpinski {1}
#expect_true "∅ is clopen in every space (here Sierpiński)" unfolding L70.IsClopen :
  L70.IsClopen sierpinski ∅
#expect_true "Sierpiński space is connected" unfolding L70.IsConnected L70.IsClopen :
  L70.IsConnected sierpinski
#expect_false "The discrete space on 2 points is connected" unfolding L70.IsConnected L70.IsClopen :
  L70.IsConnected (discrete 2)
#expect_true "The indiscrete space on 3 points is connected" unfolding L70.IsConnected L70.IsClopen :
  L70.IsConnected (indiscrete 3)
#expect_true "The chain ∅ ⊂ {0} ⊂ {0, 1} ⊂ {0, 1, 2} is connected" unfolding L70.IsConnected L70.IsClopen :
  L70.IsConnected chain3
#expect_true "Particular point topologies are connected" unfolding L70.IsConnected L70.IsClopen :
  L70.IsConnected (particularPoint 3 1)
#expect_true "The excluded-point topology is connected, although {1} and {2} are disjoint open sets" unfolding L70.IsConnected L70.IsClopen :
  L70.IsConnected (excludedPoint 3 0)
#expect_false "{∅, {0}, {1, 2}, {0, 1, 2}} is connected" unfolding L70.IsConnected L70.IsClopen :
  L70.IsConnected ({∅, {0}, {1, 2}, Finset.univ} : Family 3)
#expect_true "The one-point space is connected" unfolding L70.IsConnected L70.IsClopen :
  L70.IsConnected (discrete 1)
#expect_true "split is a topology" unfolding L70.split :
  Ref.IsTopology L70.split
#expect_true "split is not discrete" unfolding L70.split :
  L70.split ≠ discrete 3
#expect_false "split is connected (it must not be)" unfolding L70.split :
  Ref.IsConnected L70.split

#level_report
