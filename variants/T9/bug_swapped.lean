open LeanCraftGame.Topology

structure MyHomeomorph {α β : Type*} (τs : MyTopology α) (τt : MyTopology β) where
  toFun : α → β
  invFun : β → α
  left_inv : Function.LeftInverse invFun toFun
  right_inv : Function.RightInverse invFun toFun
  continuous_toFun : MyContinuous τs τt toFun
  continuous_invFun : MyContinuous τt τs invFun

def sourceTopology : MyTopology Bool := indiscrete Bool

def targetTopology : MyTopology Bool := discrete Bool

def bijection : Bool → Bool := id
