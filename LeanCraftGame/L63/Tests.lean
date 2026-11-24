/- Hidden test battery for Level Closed sets and closure. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L63.Player

open Top

#no_sorry L63.IsClosed
#no_sorry L63.interior
#no_sorry L63.closure
#no_sorry L63.IsDense
#level_start "Closed sets and closure"

#expect_true "In Sierpiński space {0} is closed" unfolding L63.IsClosed :
  L63.IsClosed sierpinski {0}
#expect_false "In Sierpiński space {1} is closed" unfolding L63.IsClosed :
  L63.IsClosed sierpinski {1}
#expect_true "The empty set is closed in every space (here the chain)" unfolding L63.IsClosed :
  L63.IsClosed chain3 ∅
#expect_true "Interior of {0} in Sierpiński space is ∅" unfolding L63.interior :
  L63.interior sierpinski {0} = ∅
#expect_true "Interior of {0, 2} in the chain ∅ ⊂ {0} ⊂ {0, 1} ⊂ {0, 1, 2} is {0}" unfolding L63.interior :
  L63.interior chain3 {0, 2} = {0}
#expect_true "Closure of {1} in Sierpiński space is everything" unfolding L63.closure :
  L63.closure sierpinski {1} = Finset.univ
#expect_true "Closure of {0} in Sierpiński space is {0}" unfolding L63.closure :
  L63.closure sierpinski {0} = {0}
#expect_true "Closure of {1} in the chain is {1, 2}" unfolding L63.closure :
  L63.closure chain3 {1} = {1, 2}
#expect_true "In a discrete space every set is its own L63.closure" unfolding L63.closure :
  ∀ A : Finset (Fin 3), L63.closure (discrete 3) A = A
#expect_true "Closure is monotone and idempotent (all subsets of the chain)" unfolding L63.closure :
  ∀ A B : Finset (Fin 3), (A ⊆ B → L63.closure chain3 A ⊆ L63.closure chain3 B) ∧
    L63.closure chain3 (L63.closure chain3 A) = L63.closure chain3 A
#expect_true "Closure is the complement of the L63.interior of the complement (all subsets of the chain)" unfolding L63.closure L63.interior :
  ∀ A : Finset (Fin 3), L63.closure chain3 A = (L63.interior chain3 Aᶜ)ᶜ
#expect_true "{1} is dense in Sierpiński space" unfolding L63.IsDense L63.closure :
  L63.IsDense sierpinski {1}
#expect_false "{0} is dense in Sierpiński space" unfolding L63.IsDense L63.closure :
  L63.IsDense sierpinski {0}
#expect_true "Particular point at 0: the point {0} is dense" unfolding L63.IsDense L63.closure :
  L63.IsDense (particularPoint 3 0) {0}

#level_report
