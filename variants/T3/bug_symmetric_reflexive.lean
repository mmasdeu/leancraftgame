def MyReflexive {α : Type*} (R : α → α → Prop) : Prop := ∀ x, R x x

def MySymmetric {α : Type*} (R : α → α → Prop) : Prop := ∀ x, R x x

def MyTransitive {α : Type*} (R : α → α → Prop) : Prop := ∀ x y z, R x y → R y z → R x z

structure MyEquivalence {α : Type*} (R : α → α → Prop) where
  reflexive : MyReflexive R
  symmetric : MySymmetric R
  transitive : MyTransitive R

def EquivClass {α : Type*} (R : α → α → Prop) (x : α) : Set α := {y | R x y}

def SameFiber {α β : Type*} (f : α → β) (x y : α) : Prop := f x = f y
