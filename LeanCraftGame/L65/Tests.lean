/- Hidden test battery for Level Continuous maps. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L65.Player

open L65 Top

#no_sorry pre
#no_sorry IsContinuous
#no_sorry IsOpenMapping
#no_sorry sneaky
#level_start "Continuous maps"

#expect_true "pre ![1, 1, 0] {1} = {0, 1}" unfolding pre :
  pre (![1, 1, 0] : Fin 3 → Fin 2) {1} = {0, 1}
#expect_true "The identity of Sierpiński space is continuous" unfolding IsContinuous pre :
  IsContinuous sierpinski sierpinski id
#expect_false "Swapping the two points of Sierpiński space is continuous" unfolding IsContinuous pre :
  IsContinuous sierpinski sierpinski ![1, 0]
#expect_true "Every map out of a discrete space is continuous (here into Sierpiński)" unfolding IsContinuous pre :
  IsContinuous (discrete 3) sierpinski ![0, 1, 1]
#expect_true "Every map into an indiscrete space is continuous" unfolding IsContinuous pre :
  IsContinuous sierpinski (indiscrete 3) ![2, 0]
#expect_true "A constant map is continuous (from Sierpiński to the discrete space)" unfolding IsContinuous pre :
  IsContinuous sierpinski (discrete 2) ![1, 1]
#expect_true "The identity from discrete {0, 1} to Sierpiński space is continuous" unfolding IsContinuous pre :
  IsContinuous (discrete 2) sierpinski id
#expect_false "The identity from Sierpiński space to discrete {0, 1} is continuous" unfolding IsContinuous pre :
  IsContinuous sierpinski (discrete 2) id
#expect_true "Chain → Sierpiński: ![0, 1, 1] is not continuous (pre {1} = {1, 2} is not open)" unfolding IsContinuous pre :
  ¬ IsContinuous chain3 sierpinski ![0, 1, 1]
#expect_true "Chain → Sierpiński: ![1, 1, 0] is continuous (pre {1} = {0, 1} is open)" unfolding IsContinuous pre :
  IsContinuous chain3 sierpinski ![1, 1, 0]
#expect_true "The identity from discrete {0, 1} to Sierpiński space is not an open map" unfolding IsOpenMapping img :
  ¬ IsOpenMapping (discrete 2) sierpinski id
#expect_true "A constant map into Sierpiński space hitting 1 is an open map from Sierpiński space" unfolding IsOpenMapping img :
  IsOpenMapping sierpinski sierpinski ![1, 1]
#expect_true "sneaky is an open map from Sierpiński space to discrete {0, 1}" unfolding sneaky :
  ∀ U ∈ sierpinski, Ref.img sneaky U ∈ discrete 2
#expect_false "sneaky is continuous from Sierpiński space to discrete {0, 1}" unfolding sneaky :
  Ref.IsContinuous sierpinski (discrete 2) sneaky

#level_report
