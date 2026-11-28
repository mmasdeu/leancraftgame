/- Hidden test battery for Level 46: Separation and compactness. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L46.Player

open Top

#no_sorry L46.IsT1
#no_sorry L46.IsT2
#no_sorry L46.noSubcover
#no_sorry L46.q1
#no_sorry L46.q2
#level_start "Separation and compactness"

#expect_false "Sierpiński space is T1" unfolding L46.IsT1 : L46.IsT1 sierpinski
#expect_true "The discrete space on 3 points is T1" unfolding L46.IsT1 : L46.IsT1 (discrete 3)
#expect_false "The particular-point topology at 0 on 3 points is T1" unfolding L46.IsT1 :
  L46.IsT1 (particularPoint 3 0)
#expect_false "The indiscrete space on 2 points is T2" unfolding L46.IsT2 : L46.IsT2 (indiscrete 2)
#expect_true "The discrete space on 3 points is T2" unfolding L46.IsT2 : L46.IsT2 (discrete 3)
#expect_true "The one-point space is T2 (no two points to separate)" unfolding L46.IsT2 :
  L46.IsT2 (indiscrete 1)
#expect_false "{∅, {0}, {1, 2}, {0, 1, 2}} is T2" unfolding L46.IsT2 :
  L46.IsT2 ({∅, {0}, {1, 2}, Finset.univ} : Family 3)
#expect_true "noSubcover covers ℕ" unfolding L46.noSubcover :
  ∀ x, ∃ i, x ∈ L46.noSubcover i
#expect_false "noSubcover has a finite subcover" unfolding L46.noSubcover :
  ∃ N, ∀ x, ∃ i ≤ N, x ∈ L46.noSubcover i
#expect_choice "Question 1: are the T1 topologies on {0, 1, 2} discrete?" : L46.q1 = true
#expect_choice "Question 2: a space where a sequence has two limits" : L46.q2 = 1

#level_report
