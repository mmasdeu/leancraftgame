/- Hidden test battery for T3 Relations and partitions. -/
import LeanCraftGame.Referee
import LeanCraftGame.T3.Player

#no_sorry T3.MyReflexive
#no_sorry T3.MySymmetric
#no_sorry T3.MyTransitive
#no_sorry T3.MyEquivalence
#no_sorry T3.EquivClass
#no_sorry T3.SameFiber
#level_start "Relations and partitions"

#expect_true "less than or equal is reflexive" unfolding T3.MyReflexive :
  T3.MyReflexive (fun a b : Nat => a ≤ b)

#expect_false "strict less than is not reflexive" unfolding T3.MyReflexive :
  T3.MyReflexive (fun a b : Nat => a < b)

#expect_true "equality is symmetric" unfolding T3.MySymmetric :
  T3.MySymmetric (fun a b : Nat => a = b)

#expect_false "less than or equal is not symmetric" unfolding T3.MySymmetric :
  T3.MySymmetric (fun a b : Nat => a ≤ b)

#expect_true "less than or equal is transitive" unfolding T3.MyTransitive :
  T3.MyTransitive (fun a b : Nat => a ≤ b)

#expect_true "an equivalence class collects related elements" unfolding T3.EquivClass :
  ∀ {α : Type*} (R : α → α → Prop) (x y : α), y ∈ T3.EquivClass R x ↔ R x y

#expect_true "the equality class is a singleton" unfolding T3.EquivClass :
  ∀ x y : Nat, y ∈ T3.EquivClass (fun a b => a = b) x ↔ y = x

#expect_true "same fibre means equal values" unfolding T3.SameFiber :
  ∀ {α β : Type*} (f : α → β) (x y : α), T3.SameFiber f x y ↔ f x = f y

#expect_true "same fibre is an equivalence relation" unfolding T3.SameFiber :
  ∀ {α β : Type*} (f : α → β) (x : α), T3.SameFiber f x x

#level_report
