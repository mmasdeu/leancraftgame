/- Continuous maps between pedagogical topologies and the Mathlib bridge. -/
import LeanCraftGame.Topology.Basic

namespace LeanCraftGame.Topology

/-- Interpret the pedagogical structure as Mathlib's `TopologicalSpace`. -/
@[instance_reducible]
def MyTopology.toTopologicalSpace {α : Type*} (τ : MyTopology α) : TopologicalSpace α where
  IsOpen := τ.IsOpen
  isOpen_univ := τ.isOpen_univ
  isOpen_inter := τ.isOpen_inter
  isOpen_sUnion := τ.isOpen_sUnion

/-- Continuity through inverse images of open sets. -/
def MyContinuous {α β : Type*} (τs : MyTopology α) (τt : MyTopology β)
    (f : α → β) : Prop :=
  ∀ s, τt.IsOpen s → τs.IsOpen (f ⁻¹' s)

lemma myContinuous_iff_continuous {α β : Type*} (τs : MyTopology α)
    (τt : MyTopology β) (f : α → β) :
    MyContinuous τs τt f ↔
      @Continuous α β τs.toTopologicalSpace τt.toTopologicalSpace f := by
  rw [continuous_def]
  rfl

lemma myContinuous_id {α : Type*} (τ : MyTopology α) : MyContinuous τ τ id := by
  intro s hs
  exact hs

lemma myContinuous_const {α β : Type*} (τs : MyTopology α) (τt : MyTopology β)
    (b : β) : MyContinuous τs τt (fun _ => b) := by
  intro s hs
  by_cases hb : b ∈ s
  · have h : (fun _ : α => b) ⁻¹' s = Set.univ := Set.preimage_const_of_mem hb
    rw [h]
    exact τs.isOpen_univ
  · have h : (fun _ : α => b) ⁻¹' s = ∅ := Set.preimage_const_of_notMem hb
    rw [h]
    exact τs.isOpen_empty

end LeanCraftGame.Topology
