/- Hidden test battery for Level A gallery of spaces. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L62.Player

open L62 Top.Ref

#no_sorry myDiscrete
#no_sorry myIndiscrete
#no_sorry mySierpinski
#no_sorry myParticular
#level_start "A gallery of spaces"

#expect_true "Your discrete family on 3 points is a topology" unfolding myDiscrete :
  IsTopology (myDiscrete 3)
#expect_true "Your discrete family on 3 points has all 8 subsets" unfolding myDiscrete :
  (myDiscrete 3).card = 8
#expect_true "Your indiscrete family on 3 points is a topology" unfolding myIndiscrete :
  IsTopology (myIndiscrete 3)
#expect_true "Your indiscrete family on 3 points has exactly 2 open sets" unfolding myIndiscrete :
  (myIndiscrete 3).card = 2
#expect_true "Your Sierpiński space is a topology" unfolding mySierpinski :
  IsTopology mySierpinski
#expect_true "In Sierpiński space {1} is open" unfolding mySierpinski :
  {1} ∈ mySierpinski
#expect_false "In Sierpiński space {0} is open" unfolding mySierpinski :
  {0} ∈ mySierpinski
#expect_true "Your particular-point family at 0 on 3 points is a topology" unfolding myParticular :
  IsTopology (myParticular 3 0)
#expect_true "Particular point at 0: {0, 2} is open" unfolding myParticular :
  {0, 2} ∈ myParticular 3 0
#expect_false "Particular point at 0: {1, 2} is open" unfolding myParticular :
  {1, 2} ∈ myParticular 3 0
#expect_true "Particular point at 0 on 3 points: 5 open sets (∅ and the four sets containing 0)" unfolding myParticular :
  (myParticular 3 0).card = 5
#expect_true "Sierpiński space is the particular-point topology at 1 on 2 points" unfolding mySierpinski myParticular :
  mySierpinski = myParticular 2 1
#expect_true "indiscrete ⊆ particular point ⊆ discrete: from coarsest to finest" unfolding myIndiscrete myParticular myDiscrete :
  myIndiscrete 3 ⊆ myParticular 3 1 ∧ myParticular 3 1 ⊆ myDiscrete 3

#level_report
