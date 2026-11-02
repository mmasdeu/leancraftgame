def AlwaysBelow {α : Type*} [Preorder α] (u : ℕ → α) (B : α) : Prop := ∀ n, u n ≤ B

def Between {α : Type*} [Preorder α] (a b x : α) : Prop := a ≤ x ∧ x ≤ b

def IsUpperBound {α : Type*} [Preorder α] (s : Set α) (B : α) : Prop := ∀ x ∈ s, x ≤ B

def largest {α : Type*} [LinearOrder α] (a b : α) : α := if a ≤ b then b else a
