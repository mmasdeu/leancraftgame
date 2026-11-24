/- Hidden test battery for Level Compactness. -/
import LeanCraftGame.Referee
import LeanCraftGame.L69.Player

open L69

#no_sorry Covers
#no_sorry HasFiniteSubcover
#no_sorry noSubcover
#no_sorry N0
#level_start "Compactness"

#expect_true "The singletons {i} cover ℕ" unfolding Covers :
  Covers (fun i => {i})
#expect_true "The initial segments {x | x < i} cover ℕ" unfolding Covers :
  Covers (fun i => {x | x < i})
#expect_false "The sets {2i} do not cover ℕ: they miss the odd numbers" unfolding Covers :
  Covers (fun i => {2 * i})
#expect_false "The initial segments {x | x < i} have no finite subcover" unfolding HasFiniteSubcover :
  HasFiniteSubcover (fun i => {x | x < i})
#expect_true "A cover whose first set is ℕ has a finite subcover" unfolding HasFiniteSubcover :
  HasFiniteSubcover (fun i => if i = 0 then Set.univ else ∅)
#expect_true "{x | i ≤ x ∨ x < 3} has a finite subcover (U 0 is everything)" unfolding HasFiniteSubcover :
  HasFiniteSubcover (fun i => {x | i ≤ x ∨ x < 3})
#expect_false "The singletons have no finite subcover" unfolding HasFiniteSubcover :
  HasFiniteSubcover (fun i => {i})
#expect_true "noSubcover covers ℕ" unfolding noSubcover :
  ∀ x, ∃ i, x ∈ noSubcover i
#expect_false "noSubcover has a finite subcover (it must not)" unfolding noSubcover :
  ∃ N, ∀ x, ∃ i ≤ N, x ∈ noSubcover i
#expect_true "V 0, …, V N0 cover ℕ" unfolding N0 :
  ∀ x : ℕ, ∃ i ≤ N0, x < i ∨ 4 ≤ x

#level_report
