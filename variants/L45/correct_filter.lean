structure FinTopology (n : Nat) where
  opens : Family n
  empty_mem : ∅ ∈ opens
  univ_mem : Finset.univ ∈ opens
  closed : ∀ U ∈ opens, ∀ V ∈ opens, U ∪ V ∈ opens ∧ U ∩ V ∈ opens

def mySierpinski : Family 2 := {∅, {1}, {0, 1}}

def myParticular (n : Nat) (p : Fin n) : Family n :=
  Finset.univ.powerset.filter (fun U => U = ∅ ∨ p ∈ U)

def IsCont {m n : Nat} (T : Family m) (S : Family n) (f : Fin m → Fin n) : Prop :=
  ∀ V ∈ S, Finset.univ.filter (fun x => f x ∈ V) ∈ T
