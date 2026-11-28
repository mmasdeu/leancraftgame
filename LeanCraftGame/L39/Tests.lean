/- Hidden test battery for Level 45: Topological spaces. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L39.Player

open L39 Top

#no_sorry mySierpinski
#no_sorry myParticular
#no_sorry IsCont
#level_start "Topological spaces"

-- the axioms: the standard examples are accepted, impostors are not
#expect_model "Sierpiński space satisfies your axioms" :
  FinTopology.mk (n := 2) sierpinski
#expect_model "The particular-point topology at 0 on 3 points satisfies your axioms" :
  FinTopology.mk (n := 3) (particularPoint 3 0)
#expect_model "The discrete topology on 3 points satisfies your axioms" :
  FinTopology.mk (n := 3) (discrete 3)
#expect_not_model "{∅, {0}} on 2 points is ruled out" :
  FinTopology.mk (n := 2) {∅, {0}}
#expect_not_model "{∅, {0, 1}, {1, 2}, {0, 1, 2}} is ruled out" :
  FinTopology.mk (n := 3) {∅, {0, 1}, {1, 2}, Finset.univ}
#expect_not_model "{∅, {0}, {1}, {0, 1, 2}} is ruled out" :
  FinTopology.mk (n := 3) {∅, {0}, {1}, Finset.univ}

-- the gallery
#expect_true "Your Sierpiński space is the referee's" unfolding mySierpinski :
  mySierpinski = sierpinski
#expect_true "Your particular-point topology at 0 on 3 points has the right open sets" unfolding myParticular :
  myParticular 3 0 = particularPoint 3 0
#expect_true "Your particular-point topology at 2 on 3 points has the right open sets" unfolding myParticular :
  myParticular 3 2 = particularPoint 3 2

-- continuity
#expect_true "The identity of Sierpiński space is continuous" unfolding IsCont Ref.pre :
  IsCont sierpinski sierpinski id
#expect_false "The identity from Sierpiński space to the discrete space on {0, 1} is continuous" unfolding IsCont Ref.pre :
  IsCont sierpinski (discrete 2) id
#expect_true "The identity from the discrete space on {0, 1} to Sierpiński space is continuous" unfolding IsCont Ref.pre :
  IsCont (discrete 2) sierpinski id
#expect_false "Swapping the two points of Sierpiński space is continuous" unfolding IsCont Ref.pre :
  IsCont sierpinski sierpinski ![1, 0]

#level_report
