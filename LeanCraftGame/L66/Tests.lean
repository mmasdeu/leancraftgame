/- Hidden test battery for Level Homeomorphisms. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L66.Player

open L66 Top

#no_sorry IsHomeo
#no_sorry mirror
#no_sorry q1
#no_sorry q2
#no_sorry q3
#level_start "Homeomorphisms"

#expect_true "The identity of Sierpiński space is a homeomorphism" unfolding IsHomeo IsContinuous pre :
  IsHomeo sierpinski sierpinski id
#expect_false "The swap is a homeomorphism of Sierpiński space to itself" unfolding IsHomeo IsContinuous pre :
  IsHomeo sierpinski sierpinski ![1, 0]
#expect_false "The identity from discrete {0, 1} to Sierpiński space (a continuous bijection) is a homeomorphism" unfolding IsHomeo IsContinuous pre :
  IsHomeo (discrete 2) sierpinski id
#expect_false "A constant map of the indiscrete space on 2 points (continuous both ways, not bijective) is a homeomorphism" unfolding IsHomeo IsContinuous pre :
  IsHomeo (indiscrete 2) (indiscrete 2) ![0, 0]
#expect_true "Every bijection between indiscrete spaces is a homeomorphism" unfolding IsHomeo IsContinuous pre :
  IsHomeo (indiscrete 3) (indiscrete 3) ![2, 0, 1]
#expect_true "Rotating the points sends particular point 0 to particular point 1" unfolding IsHomeo IsContinuous pre :
  IsHomeo (particularPoint 3 0) (particularPoint 3 1) ![1, 2, 0]
#expect_true "mirror is a bijection, continuous both ways" unfolding mirror :
  Ref.Homeomorphic sierpinski ({∅, {0}, Finset.univ} : Family 2) ∧
  Ref.IsBijective mirror ∧ Ref.IsContinuous sierpinski ({∅, {0}, Finset.univ} : Family 2) mirror ∧
  ∀ U ∈ sierpinski, Ref.img mirror U ∈ ({∅, {0}, Finset.univ} : Family 2)
#expect_true "q1: your answer agrees with the referee's exhaustive search" unfolding q1 :
  q1 = decide (Ref.Homeomorphic sierpinski (discrete 2))
#expect_true "q2: your answer agrees with the referee's exhaustive search" unfolding q2 :
  q2 = decide (Ref.Homeomorphic (particularPoint 3 0) (particularPoint 3 2))
#expect_true "q3: your answer agrees with the referee's exhaustive search" unfolding q3 :
  q3 = decide (Ref.Homeomorphic chain3 (particularPoint 3 0))

#level_report
