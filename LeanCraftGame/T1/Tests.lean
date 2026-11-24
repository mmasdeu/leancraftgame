/- Hidden test battery for T1 Sets and operations. -/
import LeanCraftGame.Referee
import LeanCraftGame.T1.Player

#no_sorry T1.MyDisjoint
#no_sorry T1.IsCover
#no_sorry T1.PreimagesPreserveOperations
#no_sorry T1.DirectImagesPreserveIntersections
#no_sorry T1.counterexampleMap
#level_start "Sets and operations"

#expect_true "disjoint means no common element" unfolding T1.MyDisjoint :
  ∀ {α : Type*} (s t : Set α), T1.MyDisjoint s t → ∀ x, x ∈ s → x ∈ t → False

#expect_true "no common element implies disjoint" unfolding T1.MyDisjoint :
  ∀ {α : Type*} (s t : Set α), (∀ x, x ∈ s → x ∈ t → False) → T1.MyDisjoint s t

#expect_true "unequal singletons are disjoint" unfolding T1.MyDisjoint :
  T1.MyDisjoint ({0} : Set Nat) {1}

#expect_false "a singleton overlaps itself" unfolding T1.MyDisjoint :
  T1.MyDisjoint ({0} : Set Nat) {0}

#expect_true "a cover supplies a family member for each point" unfolding T1.IsCover :
  ∀ {α : Type*} (s : Set α) (C : Set (Set α)), T1.IsCover s C →
    ∀ x ∈ s, ∃ U ∈ C, x ∈ U

#expect_true "the universal family covers every set" unfolding T1.IsCover :
  ∀ {α : Type*} (s : Set α), T1.IsCover s Set.univ

#expect_true "preimages preserve unions" unfolding T1.PreimagesPreserveOperations :
  ∀ {α β : Type*} (f : α → β), T1.PreimagesPreserveOperations f →
    ∀ s t : Set β, f ⁻¹' (s ∪ t) = (f ⁻¹' s) ∪ (f ⁻¹' t)

#expect_true "preimages preserve intersections" unfolding T1.PreimagesPreserveOperations :
  ∀ {α β : Type*} (f : α → β), T1.PreimagesPreserveOperations f →
    ∀ s t : Set β, f ⁻¹' (s ∩ t) = (f ⁻¹' s) ∩ (f ⁻¹' t)

#expect_true "direct images are universally quantified" unfolding T1.DirectImagesPreserveIntersections :
  ∀ {α β : Type*} (f : α → β), T1.DirectImagesPreserveIntersections f →
    ∀ s t : Set α, f '' (s ∩ t) = (f '' s) ∩ (f '' t)

#expect_true "the counterexample map is constant true" unfolding T1.counterexampleMap :
  ∀ x, T1.counterexampleMap x = true

#level_report
