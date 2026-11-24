/- Hidden test battery for T10 Subspace topology. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Basic
import LeanCraftGame.T10.Player

#no_sorry T10.subspaceTopology
#no_sorry T10.SubspaceOpen
#no_sorry T10.chosenSubset
#no_sorry T10.openNotClosedSet
#level_start "Subspace topology"

#expect_true "subspace topology is induced" unfolding T10.subspaceTopology :
  ∀ {α : Type*} (τ : TopologicalSpace α) (A : Set α),
    T10.subspaceTopology τ A = TopologicalSpace.induced (fun x : A => x.1) τ

#expect_true "subspace opens are ambient open preimages" unfolding T10.SubspaceOpen :
  ∀ {α : Type*} (τ : TopologicalSpace α) (A : Set α) (s : Set A),
    T10.SubspaceOpen τ A s → ∃ U : Set α, @IsOpen α τ U ∧ s = (fun x : A => x.1) ⁻¹' U

#expect_true "the chosen subset is singleton true" unfolding T10.chosenSubset :
  ∀ x, x ∈ T10.chosenSubset ↔ x = true

#expect_true "open not closed example is singleton true" unfolding T10.openNotClosedSet :
  ∀ x, x ∈ T10.openNotClosedSet ↔ x = true

#level_report
