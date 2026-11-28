structure FinTopology (n : Nat) where
  opens : Family n
  empty_mem : ∅ ∈ opens
  univ_mem : Finset.univ ∈ opens
  union_mem : ∀ U ∈ opens, ∀ V ∈ opens, U ∪ V ∈ opens
  inter_mem : ∀ U ∈ opens, ∀ V ∈ opens, U ∩ V ∈ opens

def mySierpinski : Family 2 := {∅, {1}, Finset.univ}

def myParticular (n : Nat) (p : Fin n) : Family n :=
  Finset.univ.powerset.filter (fun U => p ∈ U)

def IsCont {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ V ∈ S, Top.Ref.pre f V ∈ T
