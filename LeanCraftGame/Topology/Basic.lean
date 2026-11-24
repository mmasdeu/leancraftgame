/-
# A small pedagogical topology layer

`MyTopology` is used in the early topology levels so that the three axioms are
visible. It is not a replacement for Mathlib's `TopologicalSpace`; later levels
bridge to the Mathlib API.
-/
import Mathlib.Tactic

namespace LeanCraftGame.Topology

/-- A topology, with arbitrary unions and binary intersections made explicit. -/
structure MyTopology (α : Type*) where
  IsOpen : Set α → Prop
  isOpen_univ : IsOpen Set.univ
  isOpen_sUnion (C : Set (Set α)) :
    (∀ s ∈ C, IsOpen s) → IsOpen (⋃₀ C)
  isOpen_inter (s t : Set α) : IsOpen s → IsOpen t → IsOpen (s ∩ t)

namespace MyTopology

variable {α : Type*} (τ : MyTopology α)

/-- The empty set is open: it is the union of the empty family. -/
theorem isOpen_empty : τ.IsOpen ∅ := by
  have h := τ.isOpen_sUnion ∅ (by simp)
  simpa using h

/-- Indexed union is a consequence of the arbitrary-union axiom. -/
theorem isOpen_iUnion {ι : Type*} (s : ι → Set α)
    (h : ∀ i, τ.IsOpen (s i)) : τ.IsOpen (⋃ i, s i) := by
  rw [← Set.sUnion_range]
  exact τ.isOpen_sUnion (Set.range s) (by
    rintro t ⟨i, rfl⟩
    exact h i)

end MyTopology

/-- The discrete topology: every set is open. -/
def discrete (α : Type*) : MyTopology α where
  IsOpen := fun _ => True
  isOpen_univ := trivial
  isOpen_sUnion := by intros; trivial
  isOpen_inter := by intros; trivial

/-- The indiscrete topology: only `∅` and `univ` are open. -/
def indiscrete (α : Type*) : MyTopology α where
  IsOpen := fun s => s = ∅ ∨ s = Set.univ
  isOpen_univ := Or.inr rfl
  isOpen_sUnion C hC := by
    classical
    by_cases h : Set.univ ∈ C
    · right
      apply Set.eq_univ_of_univ_subset
      exact Set.subset_sUnion_of_mem h
    · left
      apply Set.sUnion_eq_empty.mpr
      intro s hs
      exact (hC s hs).resolve_right (fun hi => h (hi ▸ hs))
  isOpen_inter s t hs ht := by
    rcases hs with rfl | hs
    · exact Or.inl (Set.empty_inter t)
    rcases ht with rfl | ht
    · exact Or.inl (Set.inter_empty s)
    · rw [hs, ht]
      exact Or.inr (Set.univ_inter Set.univ)

/-- The particular-point topology at `p`: a set is open when it is empty or
contains `p`. The Sierpiński topology is the instance on `Bool` at `true`. -/
def particularPoint {α : Type*} (p : α) : MyTopology α where
  IsOpen := fun s => s = ∅ ∨ p ∈ s
  isOpen_univ := Or.inr (Set.mem_univ p)
  isOpen_sUnion C hC := by
    classical
    by_cases h : ∃ s ∈ C, p ∈ s
    · obtain ⟨s, hs, hp⟩ := h
      exact Or.inr (Set.mem_sUnion.mpr ⟨s, hs, hp⟩)
    · left
      apply Set.sUnion_eq_empty.mpr
      intro s hs
      exact (hC s hs).resolve_right (fun hp => h ⟨s, hs, hp⟩)
  isOpen_inter s t hs ht := by
    rcases hs with rfl | hs
    · exact Or.inl (Set.empty_inter t)
    rcases ht with rfl | ht
    · exact Or.inl (Set.inter_empty s)
    · exact Or.inr ⟨hs, ht⟩

/-- The cofinite topology: a set is open when it is empty or its complement
is finite. This general construction is reused for compactness and separation. -/
def cofinite (α : Type*) : MyTopology α where
  IsOpen := fun s => s = ∅ ∨ sᶜ.Finite
  isOpen_univ := Or.inr (by simp)
  isOpen_sUnion C hC := by
    classical
    by_cases h : ∃ s ∈ C, s ≠ ∅
    · obtain ⟨s, hs, hne⟩ := h
      right
      apply Set.Finite.subset ((hC s hs).resolve_left hne)
      exact Set.compl_subset_compl.mpr (Set.subset_sUnion_of_mem hs)
    · left
      apply Set.sUnion_eq_empty.mpr
      intro s hs
      exact not_not.mp (fun hne => h ⟨s, hs, hne⟩)
  isOpen_inter s t hs ht := by
    rcases hs with rfl | hs
    · exact Or.inl (Set.empty_inter t)
    rcases ht with rfl | ht
    · exact Or.inl (Set.inter_empty s)
    · right
      rw [Set.compl_inter]
      exact hs.union ht

/-- Sierpiński space on `Bool`, with `{true}` open but `{false}` not open. -/
def sierpinski : MyTopology Bool := particularPoint true

lemma sierpinski_isOpen_iff (s : Set Bool) :
    sierpinski.IsOpen s ↔ s = ∅ ∨ s = {true} ∨ s = Set.univ := by
  change (s = ∅ ∨ true ∈ s) ↔ _
  constructor
  · rintro (rfl | h)
    · exact Or.inl rfl
    by_cases hf : false ∈ s
    · exact Or.inr (Or.inr (Set.eq_univ_of_forall (fun b => by
        cases b
        · exact hf
        · exact h)))
    · exact Or.inr (Or.inl (Set.Subset.antisymm (fun b hb => by
        cases b
        · exact (hf hb).elim
        · exact rfl) (Set.singleton_subset_iff.mpr h)))
  · rintro (rfl | rfl | rfl)
    · exact Or.inl rfl
    · exact Or.inr rfl
    · exact Or.inr (Set.mem_univ true)

end LeanCraftGame.Topology
