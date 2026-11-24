/-
# Relations, classes and fibres

A relation on `α` has type `α → α → Prop`. Reflexivity, symmetry and transitivity
are independent properties. An equivalence relation has all three.

The equivalence class of `x` contains the elements related to `x`. When a family
is a partition, “belong to the same block” has exactly these three properties;
coverage gives reflexivity and disjoint blocks prevent unwanted transitivity.
A special case is already available without partitions: for `f : α → β`, the
relation `f x = f y` has classes given by the fibres `f ⁻¹' {b}`.

## Your tasks

Define the three relation predicates, package them in `MyEquivalence`, define
`EquivClass R x`, and define `SameFiber f x y` by equality of values.
-/
namespace T3

def MyReflexive {α : Type*} (R : α → α → Prop) : Prop := sorry

def MySymmetric {α : Type*} (R : α → α → Prop) : Prop := sorry

def MyTransitive {α : Type*} (R : α → α → Prop) : Prop := sorry

structure MyEquivalence {α : Type*} (R : α → α → Prop) where
  reflexive : sorry
  symmetric : sorry
  transitive : sorry

def EquivClass {α : Type*} (R : α → α → Prop) (x : α) : Set α := sorry

def SameFiber {α β : Type*} (f : α → β) (x y : α) : Prop := sorry

end T3
