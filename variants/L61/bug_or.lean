structure FinTopology (n : Nat) where
  opens : Family n
  empty_mem : ∅ ∈ opens
  univ_mem : Finset.univ ∈ opens
  closed : ∀ U ∈ opens, ∀ V ∈ opens, U ∪ V ∈ opens ∨ U ∩ V ∈ opens
