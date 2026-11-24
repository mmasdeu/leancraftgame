/- Hidden test battery for Level Sets and maps. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L58.Player

open L58

#no_sorry Disj
#no_sorry pre
#no_sorry f0
#no_sorry A0
#no_sorry B0
#level_start "Sets and maps"

#expect_true "{0} and {1, 2} are disjoint" unfolding Disj :
  Disj ({0} : Finset (Fin 3)) {1, 2}
#expect_false "{0, 1} and {1, 2} are disjoint" unfolding Disj :
  Disj ({0, 1} : Finset (Fin 3)) {1, 2}
#expect_true "∅ is disjoint from itself" unfolding Disj :
  Disj (∅ : Finset (Fin 3)) ∅
#expect_false "The whole space is disjoint from itself" unfolding Disj :
  Disj (Finset.univ : Finset (Fin 3)) Finset.univ
#expect_true "pre ![1, 1, 0] {1} = {0, 1}" unfolding pre :
  pre (![1, 1, 0] : Fin 3 → Fin 2) {1} = {0, 1}
#expect_true "pre ![1, 1, 0] {0, 1} is everything, pre ![1, 1, 0] ∅ is empty" unfolding pre :
  pre (![1, 1, 0] : Fin 3 → Fin 2) Finset.univ = Finset.univ ∧ pre (![1, 1, 0] : Fin 3 → Fin 2) ∅ = ∅
#expect_true "Your pre commutes with ∩, for every pair of subsets" unfolding pre :
  ∀ V W : Finset (Fin 3), pre (![2, 0, 0, 1] : Fin 4 → Fin 3) (V ∩ W) =
    pre ![2, 0, 0, 1] V ∩ pre ![2, 0, 0, 1] W
#expect_true "Your pre commutes with ∪ and with complements" unfolding pre :
  ∀ V W : Finset (Fin 3), pre (![2, 0, 0, 1] : Fin 4 → Fin 3) (V ∪ W) =
    pre ![2, 0, 0, 1] V ∪ pre ![2, 0, 0, 1] W ∧ pre (![2, 0, 0, 1] : Fin 4 → Fin 3) Vᶜ = (pre ![2, 0, 0, 1] V)ᶜ
#expect_true "Your counterexample: img f0 (A0 ∩ B0) ≠ img f0 A0 ∩ img f0 B0" unfolding f0 A0 B0 :
  Top.Ref.img f0 (A0 ∩ B0) ≠ Top.Ref.img f0 A0 ∩ Top.Ref.img f0 B0

#level_report
