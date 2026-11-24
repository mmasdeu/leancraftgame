/- Hidden test battery for Level Neighbourhoods, filters and convergence. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L72.Player

open Top

#no_sorry L72.nbhds
#no_sorry L72.IsFilter
#no_sorry L72.Converges
#no_sorry L72.twoLimits
#level_start "Neighbourhoods, filters and convergence"

#expect_true "In Sierpiński space the only neighbourhood of 0 is the whole space" unfolding L72.nbhds :
  L72.nbhds sierpinski 0 = {Finset.univ}
#expect_true "In Sierpiński space the neighbourhoods of 1 are {1} and {0, 1}" unfolding L72.nbhds :
  L72.nbhds sierpinski 1 = {{1}, Finset.univ}
#expect_true "In the chain, {0, 2} is a neighbourhood of 0 but not of 2" unfolding L72.nbhds :
  {0, 2} ∈ L72.nbhds chain3 0 ∧ {0, 2} ∉ L72.nbhds chain3 2
#expect_true "The neighbourhoods of 1 in the chain form a filter" unfolding L72.IsFilter L72.nbhds :
  L72.IsFilter (L72.nbhds chain3 1)
#expect_false "The family of all subsets is a (proper) filter" unfolding L72.IsFilter :
  L72.IsFilter (discrete 2)
#expect_false "{{0}, {1}, {0, 1}} is a filter (not closed under ∩)" unfolding L72.IsFilter :
  L72.IsFilter ({{0}, {1}, Finset.univ} : Family 2)
#expect_false "{{0}} is a filter on 2 points (not upward closed)" unfolding L72.IsFilter :
  L72.IsFilter ({{0}} : Family 2)
#expect_true "{{0}, {0, 1}} is a filter: the sets containing the point 0" unfolding L72.IsFilter :
  L72.IsFilter ({{0}, Finset.univ} : Family 2)
#expect_true "The constant sequence 1 converges to 1 in Sierpiński space" unfolding L72.Converges Top.sierpinski :
  L72.Converges sierpinski (fun _ => 1) 1
#expect_true "The constant sequence 1 converges to 0 in Sierpiński space" unfolding L72.Converges Top.sierpinski :
  L72.Converges sierpinski (fun _ => 1) 0
#expect_false "0, 1, 0, 1, … converges to 1 in Sierpiński space" unfolding L72.Converges Top.sierpinski :
  L72.Converges sierpinski (fun k => if k % 2 = 0 then 0 else 1) 1
#expect_true "In a discrete space, 0, 0, 0, 0, 0, 2, 2, 2, … converges to 2" unfolding L72.Converges :
  L72.Converges ({∅, {0}, {1}, {2}, {0, 1}, {0, 2}, {1, 2}, Finset.univ} : Family 3)
    (fun k => if k < 5 then 0 else 2) 2
#expect_false "In a discrete space, 0, 1, 0, 1, … converges to 1" unfolding L72.Converges :
  L72.Converges ({∅, {0}, {1}, Finset.univ} : Family 2) (fun k => if k % 2 = 0 then 0 else 1) 1
#expect_true "twoLimits converges to 0 in Sierpiński space" unfolding L72.twoLimits :
  ∀ U ∈ ({∅, {1}, Finset.univ} : Family 2), 0 ∈ U → ∃ N, ∀ k, N ≤ k → L72.twoLimits k ∈ U
#expect_true "twoLimits converges to 1 in Sierpiński space" unfolding L72.twoLimits :
  ∀ U ∈ ({∅, {1}, Finset.univ} : Family 2), 1 ∈ U → ∃ N, ∀ k, N ≤ k → L72.twoLimits k ∈ U
#expect_true "twoLimits is not constant" unfolding L72.twoLimits :
  ∃ k, L72.twoLimits k ≠ L72.twoLimits 0

#level_report
