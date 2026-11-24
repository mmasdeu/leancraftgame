/- Hidden test battery for Level Products. -/
import LeanCraftGame.Referee
import LeanCraftGame.Lib.Topology
import LeanCraftGame.L68.Player

open Top

#no_sorry L68.product
#no_sorry L68.diagonal
#no_sorry L68.q1
#level_start "Products"

#expect_true "Discrete × discrete (2 points each) is discrete: all 16 subsets are open" unfolding L68.product :
  (L68.product (discrete 2) (discrete 2)).card = 16
#expect_true "Indiscrete × indiscrete is indiscrete: 2 open sets" unfolding L68.product :
  (L68.product (indiscrete 2) (indiscrete 2)).card = 2
#expect_true "Sierpiński × Sierpiński has 6 open sets" unfolding L68.product :
  (L68.product sierpinski sierpinski).card = 6
#expect_true "{(1, 1)} is open in Sierpiński × Sierpiński" unfolding L68.product :
  {(1, 1)} ∈ L68.product sierpinski sierpinski
#expect_false "{(0, 1), (1, 0)} is open in Sierpiński × Sierpiński" unfolding L68.product :
  {(0, 1), (1, 0)} ∈ L68.product sierpinski sierpinski
#expect_true "The L-shaped set {(0, 1), (1, 0), (1, 1)} is open, though not a rectangle" unfolding L68.product :
  {(0, 1), (1, 0), (1, 1)} ∈ L68.product sierpinski sierpinski
#expect_true "The first projection is continuous: U × {0, 1} is open for every open U" unfolding L68.product :
  ∀ U ∈ sierpinski, U ×ˢ Finset.univ ∈ L68.product sierpinski (discrete 2)
#expect_true "The second projection is continuous: {0, 1} × V is open for every open V" unfolding L68.product :
  ∀ V ∈ chain3, Finset.univ ×ˢ V ∈ L68.product sierpinski chain3
#expect_true "diagonal = {(0, 0), (1, 1)}" unfolding L68.diagonal :
  L68.diagonal = {(0, 0), (1, 1)}
#expect_true "q1: your answer agrees with the referee's computation" unfolding L68.q1 :
  L68.q1 = decide (({(0, 0), (1, 1)} : Finset (Fin 2 × Fin 2))ᶜ ∈ (Finset.univ.powerset.filter
    (fun W => ∀ z ∈ W, ∃ U ∈ sierpinski, ∃ V ∈ sierpinski, z ∈ U ×ˢ V ∧ U ×ˢ V ⊆ W)))

#level_report
