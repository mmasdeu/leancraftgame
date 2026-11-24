structure MyTopology (α : Type*) where
  IsOpen : Set α → Prop
  isOpen_univ : IsOpen Set.univ
  isOpen_sUnion (C : Set (Set α)) : IsOpen C → IsOpen (⋃₀ C)
  isOpen_inter (s t : Set α) : IsOpen s → IsOpen t → IsOpen (s ∩ t)
