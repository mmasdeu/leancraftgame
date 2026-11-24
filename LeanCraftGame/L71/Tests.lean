/- Hidden test battery for Level Separation. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L71.Player

open Top

#no_sorry L71.IsT0
#no_sorry L71.IsT1
#no_sorry L71.IsT2
#no_sorry L71.kolmo
#no_sorry L71.q1
#level_start "Separation"

#expect_true "Sierpiński space is T0" unfolding L71.IsT0 :
  L71.IsT0 sierpinski
#expect_false "Sierpiński space is T1" unfolding L71.IsT1 :
  L71.IsT1 sierpinski
#expect_false "The indiscrete space on 2 points is T0" unfolding L71.IsT0 :
  L71.IsT0 (indiscrete 2)
#expect_true "The one-point space is T2 (there are no two points to separate)" unfolding L71.IsT2 :
  L71.IsT2 (indiscrete 1)
#expect_true "The discrete space on 3 points is T2" unfolding L71.IsT2 :
  L71.IsT2 (discrete 3)
#expect_true "The particular-point topology is T0" unfolding L71.IsT0 :
  L71.IsT0 (particularPoint 3 0)
#expect_false "The particular-point topology is T1" unfolding L71.IsT1 :
  L71.IsT1 (particularPoint 3 0)
#expect_false "The excluded-point topology is T1" unfolding L71.IsT1 :
  L71.IsT1 (excludedPoint 3 0)
#expect_false "{∅, {0}, {1, 2}, {0, 1, 2}} is T0 (1 and 2 cannot be told apart)" unfolding L71.IsT0 :
  L71.IsT0 ({∅, {0}, {1, 2}, Finset.univ} : Family 3)
#expect_true "T2 implies T1 implies T0, on every topology of the gallery" unfolding L71.IsT0 L71.IsT1 L71.IsT2 :
  ∀ T ∈ ({discrete 3, indiscrete 3, chain3, particularPoint 3 0, excludedPoint 3 1} : Finset (Family 3)),
    (L71.IsT2 T → L71.IsT1 T) ∧ (L71.IsT1 T → L71.IsT0 T)
#expect_true "kolmo is a topology, T0 and not T1, and not the chain" unfolding L71.kolmo :
  Ref.IsTopology L71.kolmo ∧ Ref.IsT0 L71.kolmo ∧ ¬ Ref.IsT1 L71.kolmo ∧ L71.kolmo ≠ chain3
#expect_true "q1: your answer agrees with the referee's search through all 256 families" unfolding L71.q1 :
  L71.q1 = decide (∃ T : Family 3, Ref.IsTopology T ∧ Ref.IsT1 T ∧ T ≠ discrete 3)

#level_report
