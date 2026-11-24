def UnionClosed {n : Nat} (F : Family n) : Prop := ∀ U V, U ∈ F → V ∈ F → U ∪ V ∈ F

def InterClosed {n : Nat} (F : Family n) : Prop := ∀ U V, U ∈ F → V ∈ F → U ∩ V ∈ F

def lopsided : Family 3 := {{0, 1}, {1, 2}, {1}}
