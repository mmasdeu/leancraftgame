def UnionClosed {n : Nat} (F : Family n) : Prop := ∀ U ∈ F, ∀ V ∈ F, U ∪ V ∈ F

def InterClosed {n : Nat} (F : Family n) : Prop := ∀ U ∈ F, ∀ V ∈ F, U ∩ V ∈ F

def lopsided : Family 3 := {∅, {0}, {0, 1}}
