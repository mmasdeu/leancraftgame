/- Hidden test battery for Level The definition of a topology. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L61.Player

open L61

#level_start "The definition of a topology"

-- the standard examples must be accepted
#expect_model "Sierpiński space {∅, {1}, {0, 1}} is a topology" :
  FinTopology.mk (n := 2) Top.sierpinski
#expect_model "The discrete topology on 3 points is a topology" :
  FinTopology.mk (n := 3) (Top.discrete 3)
#expect_model "The indiscrete topology on 3 points is a topology" :
  FinTopology.mk (n := 3) (Top.indiscrete 3)
#expect_model "The chain ∅ ⊂ {0} ⊂ {0, 1} ⊂ {0, 1, 2} is a topology" :
  FinTopology.mk (n := 3) Top.chain3
#expect_model "The particular-point topology at 0 on 3 points is a topology" :
  FinTopology.mk (n := 3) (Top.particularPoint 3 0)
-- impostors must be ruled out
#expect_not_model "{∅, {0}} on 2 points: the whole space is missing" :
  FinTopology.mk (n := 2) {∅, {0}}
#expect_not_model "{∅, {0, 1}, {1, 2}, {0, 1, 2}}: the intersection {1} is missing" :
  FinTopology.mk (n := 3) {∅, {0, 1}, {1, 2}, Finset.univ}
#expect_not_model "{{0}, {0, 1}}: the empty set is missing" :
  FinTopology.mk (n := 2) {{0}, Finset.univ}
#expect_not_model "{∅, {0}, {1}, {0, 1, 2}}: the union {0, 1} is missing" :
  FinTopology.mk (n := 3) {∅, {0}, {1}, Finset.univ}

#level_report
