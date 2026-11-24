open LeanCraftGame.Topology

def discreteOnNat : MyTopology Nat := indiscrete Nat

def indiscreteOnNat : MyTopology Nat := discrete Nat

def sierpinskiSpace : MyTopology Bool := particularPoint true

def particularPointAtZero : MyTopology Nat := particularPoint 0

def cofiniteOnNat : MyTopology Nat := cofinite Nat
