/- Hidden test battery for T2 Families of sets. -/
import LeanCraftGame.Referee
import LeanCraftGame.Topology.Finite
import LeanCraftGame.T2.Player

#no_sorry T2.Family
#no_sorry T2.ClosedUnderUnions
#no_sorry T2.ClosedUnderBinaryIntersections
#no_sorry T2.FiniteButNotUnionClosed
#level_start "Families of sets"

#expect_true "a family is an indexed collection of sets" unfolding Family :
  T2.Family Nat Bool = (Bool → Set Nat)

#expect_true "union closure holds for the discrete family" unfolding ClosedUnderUnions :
  T2.ClosedUnderUnions (Set.univ : Set (Set Nat))

#expect_true "union closure applies to every subfamily" unfolding ClosedUnderUnions :
  ∀ {α : Type*} (C D : Set (Set α)), T2.ClosedUnderUnions C → D ⊆ C → ⋃₀ D ∈ C

#expect_true "binary intersection closure holds for the discrete family" unfolding ClosedUnderBinaryIntersections :
  T2.ClosedUnderBinaryIntersections (Set.univ : Set (Set Nat))

#expect_true "binary intersection closure applies to every pair" unfolding ClosedUnderBinaryIntersections :
  ∀ {α : Type*} (C : Set (Set α)) (s t : Set α),
    T2.ClosedUnderBinaryIntersections C → s ∈ C → t ∈ C → s ∩ t ∈ C

#expect_true "the finite family is the intended four sets" unfolding FiniteButNotUnionClosed :
  T2.FiniteButNotUnionClosed = [∅, {0}, {1}, Finset.univ]

#expect_false "the missing union is 0,1" unfolding FiniteButNotUnionClosed :
  ({0, 1} : Finset (Fin 3)) ∈ T2.FiniteButNotUnionClosed

#expect_true "the finite family is binary intersection closed" unfolding FiniteButNotUnionClosed LeanCraftGame.Topology.Finite.badIntersection :
  LeanCraftGame.Topology.Finite.badIntersection T2.FiniteButNotUnionClosed = none

#expect_true "the finite referee identifies the union failure" unfolding FiniteButNotUnionClosed LeanCraftGame.Topology.Finite.validate :
  (LeanCraftGame.Topology.Finite.validate T2.FiniteButNotUnionClosed).map LeanCraftGame.Topology.Finite.Issue.code =
    some "axiom_violation/arbitrary_union"

#level_report
