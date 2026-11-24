open LeanCraftGame.Topology

def sourceTopology : MyTopology Bool := indiscrete Bool

def targetTopology : MyTopology Bool := discrete Bool

def bijection : Bool → Bool := id
