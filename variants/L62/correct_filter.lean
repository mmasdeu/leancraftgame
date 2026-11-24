def myDiscrete (n : Nat) : Family n := Finset.univ.filter (fun _ => True)

def myIndiscrete (n : Nat) : Family n := Finset.univ.filter (fun U => U = ∅ ∨ U = Finset.univ)

def mySierpinski : Family 2 := {∅, {1}, {0, 1}}

def myParticular (n : Nat) (p : Fin n) : Family n :=
  Finset.univ.filter (fun U => U = ∅ ∨ p ∈ U)
