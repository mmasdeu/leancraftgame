/- Hidden test battery for T9 Homeomorphisms. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Maps
import LeanCraftGame.T9.Player

#no_sorry T9.sourceTopology
#no_sorry T9.targetTopology
#no_sorry T9.bijection
#level_start "Bijective need not mean homeomorphic"

#expect_true "the source is discrete" unfolding T9.sourceTopology LeanCraftGame.Topology.discrete :
  ∀ s : Set Bool, T9.sourceTopology.IsOpen s

#expect_true "the target contains the universal set" :
  T9.targetTopology.IsOpen Set.univ

#expect_true "the proposed map is the identity" unfolding T9.bijection :
  ∀ x, T9.bijection x = x

#level_report
