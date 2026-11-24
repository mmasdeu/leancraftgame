structure FinTopology (n : Nat) where
  opens : Family n
  ends : ∅ ∈ opens ∧ Finset.univ ∈ opens
  closed : ∀ U V, U ∈ opens → V ∈ opens → U ∪ V ∈ opens ∧ U ∩ V ∈ opens
