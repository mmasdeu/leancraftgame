/- Hidden test battery for T5 Standard examples. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Basic
import LeanCraftGame.T5.Player

open LeanCraftGame.Topology

#no_sorry T5.discreteOnNat
#no_sorry T5.indiscreteOnNat
#no_sorry T5.sierpinskiSpace
#no_sorry T5.particularPointAtZero
#no_sorry T5.cofiniteOnNat
#level_start "Standard examples of topologies"

#expect_true "discrete opens every set" unfolding T5.discreteOnNat discrete :
  ∀ s : Set Nat, T5.discreteOnNat.IsOpen s

#expect_true "indiscrete opens the empty set" unfolding T5.indiscreteOnNat indiscrete :
  T5.indiscreteOnNat.IsOpen ∅

#expect_true "indiscrete opens the universal set" unfolding T5.indiscreteOnNat indiscrete :
  T5.indiscreteOnNat.IsOpen Set.univ

#expect_true "the empty set is open in Sierpinski" :
  T5.sierpinskiSpace.IsOpen ∅

#expect_true "the singleton true is open" unfolding T5.sierpinskiSpace particularPoint :
  T5.sierpinskiSpace.IsOpen {true}

#expect_false "the singleton false is not open" unfolding T5.sierpinskiSpace particularPoint :
  T5.sierpinskiSpace.IsOpen {false}

#expect_true "a particular point set is open" unfolding T5.particularPointAtZero particularPoint :
  T5.particularPointAtZero.IsOpen {0}

#expect_true "a cofinite complement is open" unfolding T5.cofiniteOnNat cofinite :
  T5.cofiniteOnNat.IsOpen {n : Nat | n ≠ 0}

#level_report
