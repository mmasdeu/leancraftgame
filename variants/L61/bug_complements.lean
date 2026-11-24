-- a sigma-algebra flavour: closed under complements, which the Sierpiński space is not
structure FinTopology (n : Nat) where
  opens : Family n
  empty_mem : ∅ ∈ opens
  univ_mem : Finset.univ ∈ opens
  union_mem : ∀ U ∈ opens, ∀ V ∈ opens, U ∪ V ∈ opens
  inter_mem : ∀ U ∈ opens, ∀ V ∈ opens, U ∩ V ∈ opens
  compl_mem : ∀ U ∈ opens, Uᶜ ∈ opens
