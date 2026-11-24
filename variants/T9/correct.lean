open LeanCraftGame.Topology

def sourceTopology : MyTopology Bool := discrete Bool

def targetTopology : MyTopology Bool := indiscrete Bool

def bijection : Bool → Bool := id
