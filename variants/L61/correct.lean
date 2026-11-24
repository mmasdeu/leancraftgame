structure FinTopology (n : Nat) where
  opens : Family n
  empty_mem : ∅ ∈ opens
  univ_mem : Finset.univ ∈ opens
  union_mem : ∀ U ∈ opens, ∀ V ∈ opens, U ∪ V ∈ opens
  inter_mem : ∀ U ∈ opens, ∀ V ∈ opens, U ∩ V ∈ opens
