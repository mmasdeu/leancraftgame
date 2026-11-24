/- Automated mathematical and finite-model regression tests. -/
import LeanCraftGame.Topology.Finite
import LeanCraftGame.Topology.Maps

namespace LeanCraftGame.Topology.Tests

open LeanCraftGame.Topology.Finite

/-- Standard general examples satisfy the pedagogical structure. -/
example : (discrete Nat).IsOpen {1, 2} := trivial
example : (indiscrete Nat).IsOpen ∅ := Or.inl rfl
example : ¬ (indiscrete Nat).IsOpen {1} := by simp [indiscrete]
example : sierpinski.IsOpen {true} := Or.inr rfl
example : ¬ sierpinski.IsOpen {false} := by simp [sierpinski, particularPoint]

/-- Identity and constant maps are continuous in the pedagogical layer. -/
example (τ : MyTopology Nat) : MyContinuous τ τ id := myContinuous_id τ
example (τs : MyTopology Nat) (τt : MyTopology Bool) :
    MyContinuous τs τt (fun _ => true) := myContinuous_const τs τt true

/-- The pedagogical and Mathlib definitions of continuity agree. -/
example (τs : MyTopology Nat) (τt : MyTopology Bool) (f : Nat → Bool) :
    MyContinuous τs τt f ↔
      @Continuous Nat Bool τs.toTopologicalSpace τt.toTopologicalSpace f :=
  myContinuous_iff_continuous τs τt f

/-- The empty axiom is derived, not separately assumed. -/
example (τ : MyTopology Nat) : τ.IsOpen ∅ := τ.isOpen_empty

/-- Standard finite examples pass exhaustive checks. -/
example : validate (discreteFamily) = none := by decide
example : validate (indiscreteFamily (α := Fin 3)) = none := by decide
example : validate sierpinskiFamily = none := by decide

private def twoOpen : List (Finset (Fin 3)) := [∅, {0, 1}, {1, 2}, Finset.univ]
private def threePoints : List (Finset (Fin 3)) := [∅, {0}, {1}, Finset.univ]
private def noEmpty : List (Finset (Fin 2)) := [Finset.univ]
private def noUnion : List (Finset (Fin 2)) := [∅, {0}, Finset.univ]

/-- A family missing the empty set is rejected with that exact diagnosis. -/
example : (validate noEmpty).map Issue.code =
    some "axiom_violation/missing_empty_set" := by native_decide

/-- A singleton-only family still contains `∅`, but misses `univ`. -/
example : (validate ([∅] : List (Finset (Fin 2)))).map Issue.code =
    some "axiom_violation/missing_universal_set" := by native_decide

/-- `twoOpen` has `∅` and `univ`, but `{1}` is missing, so intersections fail. -/
example : (validate twoOpen).map Issue.code =
    some "axiom_violation/binary_intersection" := by native_decide

/-- `threePoints` is binary-intersection closed but not closed under unions. -/
example : badIntersection threePoints = none := by native_decide
example : (validate threePoints).map Issue.code =
    some "axiom_violation/arbitrary_union" := by native_decide

/-- The union diagnostic includes the actual missing union `{0,1}`. -/
example : (validate threePoints).map (fun i => i.witnesses.getLast?) =
    some (some ({0, 1} : Finset (Fin 3))) := by native_decide

end LeanCraftGame.Topology.Tests
