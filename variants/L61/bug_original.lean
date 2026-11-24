structure FinTopology (n : Nat) where
  opens : Family n
  empty_mem : ∅ ∈ opens
  union_mem : ∀ U ∈ opens, ∀ V ∈ opens, U ∪ V ∈ opens
