/- Hidden test battery for Level Subspaces. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L67.Player

open Top

#no_sorry L67.subspace
#no_sorry L67.OpenIn
#no_sorry L67.A0
#no_sorry L67.W0
#no_sorry L67.D0
#level_start "Subspaces"

#expect_true "Sierpiński space on {1}: the opens are ∅ and {1}" unfolding L67.subspace :
  L67.subspace sierpinski {1} = {∅, {1}}
#expect_true "The chain on {1, 2}: ∅, {1}, {1, 2} (a copy of Sierpiński space)" unfolding L67.subspace :
  L67.subspace chain3 {1, 2} = {∅, {1}, {1, 2}}
#expect_true "Particular point 0 on {1, 2}: every subset is open (discrete)" unfolding L67.subspace :
  L67.subspace (particularPoint 3 0) {1, 2} = {∅, {1}, {2}, {1, 2}}
#expect_true "The subspace topology is a topology (on the subset): chain on {0, 2}" unfolding L67.subspace :
  ∅ ∈ L67.subspace chain3 {0, 2} ∧ {0, 2} ∈ L67.subspace chain3 {0, 2} ∧
    ∀ U ∈ L67.subspace chain3 {0, 2}, ∀ V ∈ L67.subspace chain3 {0, 2},
      U ∪ V ∈ L67.subspace chain3 {0, 2} ∧ U ∩ V ∈ L67.subspace chain3 {0, 2}
#expect_true "{1} is open in the subspace {1, 2} of the chain" unfolding L67.OpenIn L67.subspace :
  L67.OpenIn chain3 {1, 2} {1}
#expect_false "{2} is open in the subspace {1, 2} of the chain" unfolding L67.OpenIn L67.subspace :
  L67.OpenIn chain3 {1, 2} {2}
#expect_true "W0 is open in A0 (and is a subset of A0)" unfolding L67.A0 L67.W0 :
  L67.W0 ⊆ L67.A0 ∧ ∃ U ∈ chain3, U ∩ L67.A0 = L67.W0
#expect_false "W0 is open in the chain (it must not be)" unfolding L67.W0 :
  L67.W0 ∈ chain3
#expect_true "D0 has at least two points, and every subset of D0 is open in D0" unfolding L67.D0 :
  2 ≤ L67.D0.card ∧ ∀ W ⊆ L67.D0, ∃ U ∈ particularPoint 3 0, U ∩ L67.D0 = W

#level_report
