/- Hidden test battery for T14 Separation axioms. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Maps
import LeanCraftGame.T14.Player

open LeanCraftGame.Topology

#no_sorry T14.MyT0
#no_sorry T14.MyT1
#no_sorry T14.MyHausdorff
#level_start "Separation axioms"

#expect_true "T0 distinguishes points in at least one direction" unfolding T14.MyT0 :
  ∀ {α : Type*} (τ : MyTopology α), T14.MyT0 τ →
    ∀ x y : α, x ≠ y → ∃ U, τ.IsOpen U ∧ (x ∈ U ∧ y ∉ U ∨ y ∈ U ∧ x ∉ U)

#expect_true "T1 separates the first point from the second" unfolding T14.MyT1 :
  ∀ {α : Type*} (τ : MyTopology α), T14.MyT1 τ →
    ∀ x y : α, x ≠ y → ∃ U, τ.IsOpen U ∧ x ∈ U ∧ y ∉ U

#expect_true "Hausdorff gives disjoint neighbourhoods" unfolding T14.MyHausdorff :
  ∀ {α : Type*} (τ : MyTopology α), T14.MyHausdorff τ →
    ∀ x y : α, x ≠ y → ∃ U V, τ.IsOpen U ∧ τ.IsOpen V ∧ x ∈ U ∧ y ∈ V ∧ U ∩ V = ∅

#level_report
