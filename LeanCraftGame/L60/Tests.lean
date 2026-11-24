/- Hidden test battery for Level Relations and partitions. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L60.Player

open L60

def kmapL60 : Fin 4 → Fin 3 := ![2, 0, 2, 1]

#no_sorry IsEquivalence
#no_sorry cls
#no_sorry kernel
#no_sorry twoBlocks
#level_start "Relations and partitions"

#expect_true "Same parity is an equivalence relation on {0, 1, 2, 3}" unfolding IsEquivalence :
  IsEquivalence (fun x y : Fin 4 => x.val % 2 == y.val % 2)
#expect_false "x ≤ y is an equivalence relation (it is not symmetric)" unfolding IsEquivalence :
  IsEquivalence (fun x y : Fin 3 => decide (x ≤ y))
#expect_false "x ≠ y is an equivalence relation (it is not reflexive)" unfolding IsEquivalence :
  IsEquivalence (fun x y : Fin 3 => x != y)
#expect_false "\"differ by at most 1\" is an equivalence relation (it is not transitive)" unfolding IsEquivalence :
  IsEquivalence (fun x y : Fin 3 => decide (x.val ≤ y.val + 1 ∧ y.val ≤ x.val + 1))
#expect_true "Everything related to everything is an equivalence relation (one class)" unfolding IsEquivalence :
  IsEquivalence (fun _ _ : Fin 3 => true)
#expect_true "The class of 1 under same parity on {0, 1, 2, 3} is {1, 3}" unfolding cls :
  cls (fun x y : Fin 4 => x.val % 2 == y.val % 2) 1 = {1, 3}
#expect_true "The class of 2 under equality is {2}" unfolding cls :
  cls (fun x y : Fin 3 => x == y) 2 = {2}
#expect_true "The kernel of ![0, 1, 0, 1] relates 0 and 2, not 0 and 1" unfolding kernel :
  kernel (![0, 1, 0, 1] : Fin 4 → Fin 2) 0 2 = true ∧ kernel (![0, 1, 0, 1] : Fin 4 → Fin 2) 0 1 = false
#expect_true "The kernel of a map is an equivalence relation (checked for ![2, 0, 2, 1])" unfolding kernel :
  ∀ x y z : Fin 4, kernel kmapL60 x x = true ∧ (kernel kmapL60 x y = true → kernel kmapL60 y x = true) ∧
    (kernel kmapL60 x y = true → kernel kmapL60 y z = true → kernel kmapL60 x z = true)
#expect_true "twoBlocks is reflexive, symmetric and transitive" unfolding twoBlocks :
  ∀ x y z : Fin 4, twoBlocks x x = true ∧ (twoBlocks x y = true → twoBlocks y x = true) ∧
    (twoBlocks x y = true → twoBlocks y z = true → twoBlocks x z = true)
#expect_true "twoBlocks has a class of size 1 and a class of size 3, and no other" unfolding twoBlocks :
  (Finset.univ.image (fun x : Fin 4 => (Finset.univ.filter (fun y => twoBlocks x y = true)).card)) = {1, 3}

#level_report
