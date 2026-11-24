def myDiscrete (n : Nat) : Family n := Finset.univ.powerset

def myIndiscrete (n : Nat) : Family n := {∅, Finset.univ}

def mySierpinski : Family 2 := {∅, {0}, Finset.univ}

def myParticular (n : Nat) (p : Fin n) : Family n :=
  insert ∅ (Finset.univ.powerset.filter (fun U => p ∈ U))
