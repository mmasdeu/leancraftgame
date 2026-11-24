/- Hidden test battery for T7 Bases and generated topologies. -/
import LeanCraftGame.Referee
import Mathlib.Topology.Instances.Real.Lemmas
import LeanCraftGame.T7.Player

#no_sorry T7.CoversBy
#no_sorry T7.IntersectionRefines
#no_sorry T7.GeneratedOpen
#no_sorry T7.twoPointBasis
#level_start "Bases and generated topologies"

#expect_true "a basis covers every point" unfolding T7.CoversBy :
  ∀ {α : Type*} (B : Set (Set α)), T7.CoversBy B → ∀ x, ∃ U ∈ B, x ∈ U

#expect_true "basis pairs have local intersection refinements" unfolding T7.IntersectionRefines :
  ∀ {α : Type*} (B : Set (Set α)) (U V : Set α) (x : α),
    T7.IntersectionRefines B → U ∈ B → V ∈ B → x ∈ U ∩ V →
      ∃ W ∈ B, x ∈ W ∧ W ⊆ U ∩ V

#expect_true "generated opens are unions of a subfamily" unfolding T7.GeneratedOpen :
  ∀ {α : Type*} (B : Set (Set α)) (s : Set α), T7.GeneratedOpen B s → ∃ C : Set (Set α), C ⊆ B ∧ s = ⋃₀ C

#expect_true "the two point basis has exactly the singletons" unfolding T7.twoPointBasis :
  ∀ U : Set Bool, U ∈ T7.twoPointBasis ↔ U = {true} ∨ U = {false}

#level_report
